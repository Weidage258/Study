using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {            
            return View();
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Account account)
        {
            //模型验证
            if (!ModelState.IsValid || account.Remark != Session["sn"].ToString())
            {
                return View();
            }
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                var result = db.Account.Where(a => a.LoginName == account.LoginName && a.LoginPWD == account.LoginPWD).FirstOrDefault();
                if (result == null)
                {
                    return View();
                }
                else
                {
                    Session["Login"] = null;
                    Session["Login"] = result;
                    if (result.LoginName=="admin")
                    {
                        Session["Menus"] = db.Menus.ToList();
                    }
                    else
                    {
                        Session["Menus"] = db.AccountMenus.Where(m=>m.AccountID== result.AccountID).ToList();
                    }
                    return RedirectToAction("Index", "Home");
                }
            }

        }
        //实用SHA1加密密码
        private static string PasswordEncryption(string pwd)
        {
            //创建SHA1加密算法对象
            SHA1 sha1 = SHA1.Create();
            //将原始密码转换为字节数组
            byte[] originalPwd = Encoding.UTF8.GetBytes(pwd);
            //执行加密
            byte[] encryPwd = sha1.ComputeHash(originalPwd);
            //将加密后的字节数组转换为小写字符串
            return string.Join("", encryPwd.Select(b => string.Format("{0:x2}", b)).ToArray()).ToLower();
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult LoginOut()
        {
            Session["Login"] = null;
            return RedirectToAction("Login","Home");
        }
    }
}