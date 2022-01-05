using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class LoginController : Controller
    {

        public ActionResult Index()
        {

            return View();

        }
            // GET: Login
            //登录界面
            [HttpPost]
        public ActionResult Index(Staff staff)
        {
            if (staff.Staff_Remark != Session["sn"].ToString())
            {
                return View();
            }
            using (WagemanagementEntities db = new WagemanagementEntities()) {
                var yuangong = db.Staff.Where(s=>s.Staff_id==staff.Staff_id&&s.Staff_Pwd==staff.Staff_Pwd).FirstOrDefault();
                if (yuangong == null)
                {
                  return Content("<script >alert('账号或密码错误')</script >");
                }
                else {
                    Session["Staff_id"] = yuangong.Staff_id;
                        Session["id"] = yuangong.Role_id;
                        Session["Login"] = yuangong.Staff_Name;
                        return RedirectToAction("Index", "Home");
                }

               
            }
            
        }
        public ActionResult Niu(int id)
        {


            if (id == 1)
            {
                return Content("false");
            }
            else if (id == 2) {
                return Content("false1");
            }
            else
                return Content("true");
        }
     

    }
}