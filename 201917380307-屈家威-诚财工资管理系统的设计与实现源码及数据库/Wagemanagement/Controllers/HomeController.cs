using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class HomeController : Controller
    {
        //主页面
        public ActionResult Index()
        {
            return View();
        }
        //修改密码
        public ActionResult modifyPwd()
        {
            return View();
        }
        //修改密码
        [HttpPost]
        public ActionResult ModifyPwd(string password1, string password2,string password3, int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                {

                    var data = db.Staff.FirstOrDefault(p => p.Staff_Pwd == password1);
                    if (data == null)
                    {
                        return Json(new
                        {
                            message = "原密码错误",
                            sadawd = false
                        });
                    }
                    else if (password1 == password2)
                    {
                        return Json(new
                        {
                            message = "原密码与修改密码一致",
                            sadawd = false
                        });
                    }
                    else if (password2 != password3)
                    {
                        return Json(new
                        {
                            message = "两次密码不一致",
                            sadawd = false
                        });
                    }
                  

                    else
                    {
                        var userObject = db.Staff.FirstOrDefault(p => p.Staff_id == id);
                        if (userObject != null)
                        {
                            userObject.Staff_Pwd = password2;

                        }
                        db.SaveChanges();


                        return Json(new
                        {
                            message = "正确",
                            sadawd = true
                        });
                    }
                  
                  
                }

            }

        }
        //奖金
        public ActionResult Bonus()
        {
            using (WagemanagementEntities db = new WagemanagementEntities()) {

                var bouns = db.Bonus.ToList();
                return View(bouns);
            }
                
        }
        public ActionResult Bounus(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var bouns = db.Bonus.FirstOrDefault(p=>p.Bonus_Id==id);
                if (bouns!=null)
                {
                    db.Bonus.Remove(bouns);
                    db.SaveChanges();
                    return RedirectToAction("Home", "Index");
                }

                return View(bouns);
            }

        }
    }
}