using MotoPartsBLL;
using MotoPartsCommon;
using MotoPartsWebApp.Common;
using MotoPartsWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MotoPartsWebApp.Controllers
{
    public class HomeController : Controller
    {
        // -------------------
        // WebApp Pages
        //---------------------
        public ActionResult Index()
        {

            return View();
        }



        public ActionResult About()
        {
            ViewBag.Message = "MotoParts";

            return View();
        }



        public ActionResult Contact()
        {
            ViewBag.Message = "Contact MotoParts.";

            return View();
        }



        public ActionResult Landing()
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {
                ViewBag.Title = "Home";

                return View();
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // User view for all parts
        public ActionResult ViewAllParts(DirtbikeModel iDirtbikeModel, PartModel iPartModel)
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {

                MapperDirtbike map = new MapperDirtbike();
                Dirtbike iDirtbike = new Dirtbike();
                iDirtbike = map.MapDirtbike(iDirtbikeModel);
                DirtbikeBLL selectDirtbike = new DirtbikeBLL();

                // Returned list of Dirtbikes from Database
                List<Dirtbike> listDirtbike = selectDirtbike.Select(iDirtbike);

                /* Get Dirtbike values from database and set it to 
                viewbag to pass it to view for drop downlist*/
                IEnumerable<SelectListItem> makes = listDirtbike.Select(m => new SelectListItem
                {
                    Value = m.Make,
                    Text = m.Make
                });
                ViewBag.Make = makes;
                IEnumerable<SelectListItem> makeYear = listDirtbike.Select(m => new SelectListItem
                {
                    Value = m.MakeYear.ToString(),
                    Text = m.MakeYear.ToString()
                });
                ViewBag.MakeYear = makeYear;
                IEnumerable<SelectListItem> models = listDirtbike.Select(m => new SelectListItem
                {
                    Value = m.Model,
                    Text = m.Model
                });
                ViewBag.Model = models;


                /* PartModel */
                PartMapper partMap = new PartMapper();
                Part iPart = new Part();
                iPart = partMap.MapDirtbike(iPartModel);
                PartBLL selectPart = new PartBLL();

                // Create List object for returned parts
                List<Part> listParts = selectPart.SelectAllParts(iPart);

                return View(listParts);
            }
            else
            {
                return RedirectToAction("login", "home");

            }
        }


        // User View for specific part
        public ActionResult ViewPart(PartModel iPartID)
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {
                ViewBag.Title = "Part View";


                /* PartModel */
                PartMapper partMap = new PartMapper();
                Part iPart = new Part();
                iPart = partMap.MapDirtbike(iPartID);
                PartBLL selectPart = new PartBLL();

                // Create List object for returned parts where partID is the same as partID from user clicked part in Parts view
                List<Part> part = selectPart.SelectAllParts(iPart).Where(p => p.PartID == iPartID.PartID).ToList();

                return View(part);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Places added part to Users Cart
        [HttpGet]
        public ActionResult AddPartToCart(int UserIDFK, int PartIDFK, decimal PartPrice, string PartName, string PartBrand, string Picture)
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {
                AddPartToCartBLL iAddPartToCartBLL = new AddPartToCartBLL();
                iAddPartToCartBLL.AddPartToCart(UserIDFK, PartIDFK, PartPrice, PartName, PartBrand, Picture);

                //return RedirectToAction("ViewAllParts", "home");
                return RedirectToAction("ViewPart", "home", new { PartID = PartIDFK });
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // User View for their cart
        public ActionResult ViewCart(int iUserID)
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {
                // Collect users parts in their Cart by using user ID
                ViewCartBLL viewCartBLL = new ViewCartBLL();
                List<Part> listPartsInCart = viewCartBLL.GetPartsInCart(iUserID);

                // Create instance of CartModel
                CartModel cm = new CartModel();

                // Calculate sub total price with list of Parts
                // Calulate sales tax total by multiplying tax rate to sub total
                // Add tax and sub total to calculate Cart total
                cm.CartSubtotal = viewCartBLL.GetCartSubtotal(listPartsInCart);
                cm.TaxTotal = viewCartBLL.GetCartTaxTotal(cm.CartSubtotal);
                cm.CartTotal = viewCartBLL.GetCartTotal(cm.TaxTotal, cm.CartSubtotal);

                // Add listPartsInCart to CartModel
                cm.PartList = listPartsInCart;

                return View(cm);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Unadds a part from users cart
        public ActionResult DeletePartFromCart(int iUserID, int iPartID)
        {
            // Must be logged in to any role to access this view
            if (((LoginModel)Session["loginModel"]) != null)
            {
                DeletePartFromCartBLL deletePartFromCartBLL = new DeletePartFromCartBLL();
                deletePartFromCartBLL.DeletePartFromCart(iUserID, iPartID);

                // Return iUserID becuase it is needed for cart view
                return RedirectToAction("ViewCart", "home", new { iUserID = iUserID});
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        /*-----------------
         * ----------------
         * Admin Controllers
         * ----------------------------------------------------------
         ------------------*/
        public ActionResult AdminLanding(UserModel userModel)
        {
            // Must be admin to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
            {
                // Create the user objrct that will recieve the mapped object
                User user = new User();

                // create BLL object for login process
                LoginBLL login = new LoginBLL();

                // passed the mapped 
                List<User> listUser = login.Login(user);

                return View(listUser);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin view of user table
        [HttpGet]
        public ActionResult AdminViewUserTable(UserModel userModel)
        {
            // Must be admin to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
            {
                User user = new User();
                ViewAllUsersBLL viewALL = new ViewAllUsersBLL();
                List<User> listUsers = viewALL.ViewAllUsers(user);

                return View(listUsers);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin Update a users role
        [HttpGet]
        public ActionResult UpdateRole(int userID, string userFullName, int roleID, RoleModel iRoleModel)
        {

            // Must be admin to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
            {

                ViewBag.ID = userID;
                ViewBag.FullName = userFullName;


                RoleMapper iRoleMapper = new RoleMapper();
                Role iRole = new Role();
                iRole = iRoleMapper.MapRole(iRoleModel);
                RoleBLL iRoleBLL = new RoleBLL();

                List<Role> listRoles = iRoleBLL.CollectRoles(iRole);


                /* Get Role values from database and set it to 
                    viewbag to pass it to view for drop downlist*/
                IEnumerable<SelectListItem> roles = listRoles.Select(m => new SelectListItem
                {
                    Value = m.RoleID.ToString(),
                    Text = m.RoleName
                });
                ViewBag.RoleId = roles;

                return View(listRoles);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }



        // Admin Update a users role
        [HttpPost]
        public ActionResult UpdateRole(int UserId, int RoleId)
        {
            // Must be admin to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
            {

                UpdateRoleBLL updateRoleBll = new UpdateRoleBLL();
                bool b = updateRoleBll.UpdateRole(UserId, RoleId);

                return RedirectToAction("AdminViewUserTable", "Home");
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin view for parts table
        [HttpGet]
        public ActionResult ViewPartsTable()
        {
            // Must be admin or moderator to access
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {
                Part iPart = new Part();
                PartBLL selectPart = new PartBLL();

                // Create List object for returned parts
                List<Part> listParts = selectPart.SelectAllParts(iPart);

                return View(listParts);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin add part to part table
        [HttpGet]
        public ActionResult AddPart()
        {
            // Must be admin or moderator to access
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {
                return View();
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin add part to part table
        [HttpPost]
        public ActionResult AddPart(Part iPart)
        {
            // Must be admin or moderator to access
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {

                AddPartBLL addPartBLL = new AddPartBLL();
                bool b = addPartBLL.AddPart(iPart);

                return RedirectToAction("ViewPartsTable", "home");

            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin Update part - pre populates form with current part values
        [HttpGet]
        public ActionResult UpdatePart(int PartId, int dirtbikeIDFK, string partName, string picture, decimal price, string partDescription, int brandIDFK, int categoryIDFK)
        {

            // Must be admin or moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {

                return View();
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin update part
        [HttpPost]
        public ActionResult UpdatePart(Part iPart)
        {
            // Must be admin or moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {

                UpdatePartBLL updatePartBLL = new UpdatePartBLL();
                updatePartBLL.UpdatePart(iPart);

                return RedirectToAction("ViewPartsTable", "Home");
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin delete part
        public ActionResult DeletePart(int PartId)
        {
            // Must be admin or moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {

                DeletePartBLL deletePartBLL = new DeletePartBLL();
                bool b = deletePartBLL.DeletePart(PartId);

                return RedirectToAction("ViewPartsTable", "Home");
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin View error table
        [HttpGet]
        public ActionResult ViewErrorTable()
        {
            // Must be admin to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
            {
                Error er = new Error();
                ViewErrorsBLL viewErrorBLL = new ViewErrorsBLL();

                List<Error> listErrors = viewErrorBLL.ViewAllErrors(er);

                return View(listErrors);
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }


        // Admin and moderator cascade delete
        [HttpGet]
        public ActionResult DeleteBikeAndParts()
        {
            // Must be admin or moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {
                return View();
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }
        [HttpPost]
        public ActionResult DeleteBikeAndParts(int iBikeID)
        {
            // Must be admin or moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK != 3)
            {

                DeleteBikeAndPartsBLL iDeleteBikeAndPartsBLL = new DeleteBikeAndPartsBLL();
                bool b = iDeleteBikeAndPartsBLL.CascadeDeletePartAndDirtbike(iBikeID);

                return RedirectToAction("DeleteBikeAndParts", "Home");
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }

        // -----------------------------------------------------
        // -----------------------------------------------------

        public ActionResult ModeratorLanding()
        {
            // Must be Moderator to access view
            if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 4)
            {
                return View();
            }
            else
            {
                return RedirectToAction("login", "home");
            }
        }



        // View Current logged in profile
        public ActionResult UserProfile()
        {
            return View();
        }





        /*-----------------
         * ----------------
         * Sign Up, Sign In, and Sign Out
         * ----------------------------------------------------------
         ------------------*/

        // Register
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Register(UserModel userModel)
        {
            if (ModelState.IsValid)
            {
                Mapper map = new Mapper();
                // Create the user object that will recieve the mapped object
                MotoPartsCommon.User user = new MotoPartsCommon.User();
                user = map.MapUser(userModel);

                // Create BLL object for registration process
                RegistrationBLL reg = new RegistrationBLL();
                User u = reg.Register(user);

                // After inserting user into database log the user in 
                LoginModel loginModel = new LoginModel();
                LoginBLL login = new LoginBLL();
                List<User> listUser = login.Login(u);

                // If theres a user returned 
                if (listUser.Count == 1)
                {
                    // Set properties from gathered match in Database to model (login model is used for the session var)
                    loginModel.UserID = listUser[0].UserID;
                    loginModel.FirstName = listUser[0].FirstName;
                    loginModel.LastName = listUser[0].LastName;
                    loginModel.UserName = listUser[0].UserName;
                    loginModel.Email = listUser[0].Email;
                    loginModel.RoleIDFK = listUser[0].RoleIDFK;
                    loginModel.Salt = listUser[0].Salt;
                    loginModel.SavedDirtbikeIDFK = listUser[0].SavedDirtbikeIDFK;
                    loginModel.UserPassword = listUser[0].UserPassword;

                    // Track users properties for session
                    Session["loginModel"] = loginModel;

                    return RedirectToAction("Landing", "Home", loginModel); 
                }
            }
            // if forum is not blank but not valid tell user the Username is already used
            if (userModel.FirstName != null && userModel.LastName != null && userModel.UserName != null && userModel.UserPassword != null && userModel.Email != null)
            {
                ViewBag.Message = "This username is already being used.";
            }
            return View(userModel);
        }


        // Login
        [HttpGet]
        public ActionResult LogIn()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Login(LoginModel loginModel)
        {
            // Instatiate
            MapperLogin map = new MapperLogin();
            User user = new User();
            LoginBLL login = new LoginBLL();

            // Map LoginModel to User
            user = map.MapUser(loginModel);

            // Returned User 
            List<User> listUser = login.Login(user);

            // If theres a user returned 
            if (listUser.Count == 1)
            {
                // Set properties from gathered match in DAL to model (model is used for the session var)
                loginModel.UserID = listUser[0].UserID;
                loginModel.FirstName = listUser[0].FirstName;
                loginModel.LastName = listUser[0].LastName;
                loginModel.UserName = listUser[0].UserName;
                loginModel.Email = listUser[0].Email;
                loginModel.RoleIDFK = listUser[0].RoleIDFK;
                loginModel.Salt = listUser[0].Salt;
                loginModel.SavedDirtbikeIDFK = listUser[0].SavedDirtbikeIDFK;
                loginModel.UserPassword = listUser[0].UserPassword;

                // Track users properties for session
                Session["loginModel"] = loginModel;

                // Redirect User role back to index
                if (((LoginModel)Session["loginModel"]).RoleIDFK == 3)
                {
                    return RedirectToAction("Landing", "Home", loginModel);
                }

                // Redirect Admin role to AdminLanding
                if (((LoginModel)Session["loginModel"]).RoleIDFK == 1)
                {
                    return RedirectToAction("AdminLanding", "Home", loginModel);
                }

                // Redirect Moderator role to ModeratorLanding
                if (((LoginModel)Session["loginModel"]).RoleIDFK == 4)
                {
                    return RedirectToAction("ModeratorLanding", "Home", loginModel);
                }
            }

            // No users returned redirect back to log in with message
            if(listUser.Count == 0)
            {
                // if input is not blank show invalid message
                if (loginModel.UserName != null || loginModel.UserPassword != null)
                {
                   ViewBag.Message = "You have entered an invalid username or password.";
                }
                return View(loginModel);
            }
            return View();
        }


        // Abandon session to Sign Out
        [HttpGet]
        public ActionResult Signout()
        {
            Session.Abandon();

            return RedirectToAction("Index", "Home");
        }


        // Delete user from admin 
        // User can delete their profile
        public ActionResult DeleteUser(int UserId)
        {
            // Must be logged in to delete
            if (((LoginModel)Session["loginModel"]) != null)
            {
                // if admin return to view user table
                // if user return to home page
                DeleteUserBLL deleteUserBLL = new DeleteUserBLL();
                bool b = deleteUserBLL.DeleteUser(UserId);

                // Must be admin to access view
                if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 1)
                {
                    return RedirectToAction("AdminViewUserTable", "Home");
                }
                // If user deletes their account return to index
                if (((LoginModel)Session["loginModel"]) != null && ((LoginModel)Session["loginModel"]).RoleIDFK == 3)
                {
                    Session.Abandon();
                    return RedirectToAction("index", "Home");
                }
            }
        
            return RedirectToAction("login", "Home");
        }

        // -----------------------------------------------------
        // -----------------------------------------------------

    }
}