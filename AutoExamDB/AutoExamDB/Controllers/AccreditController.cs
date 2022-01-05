using AutoExamDB.Filters;
using AutoExamDB.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    [Login]
    [AuthMenus]
    public class AccreditController : Controller
    {
        AutoExamDBEntities db = new AutoExamDBEntities();
        // GET: Accredit
        public ActionResult Index()
        {
            return View();
        }
        //账户-角色授权:AccountRole
        public ActionResult AccountRole(int AccountType=3,string LoginName="")
        {
            ViewBag.Accounts = db.Account.
                Where(a=>(AccountType == 3 || a.AccountType == AccountType)
                &&(LoginName==""||a.LoginName== LoginName)).ToList();

            ViewBag.Roles = db.Roles.ToList();            
            return View(db.AccountRoles.ToList());
        }
        [HttpPost]
        public void AccountRole(string accountRoles)
        {
            //接受Ajax传过来的json数据并转化成集合
            var result = JsonConvert.DeserializeObject<List<AccountRoles>>(accountRoles);
            //获取当前用户ID
            int accountId = result[0].AccountID;
            //获取当前用户所有的角色关系
            var items = db.AccountRoles.Where(a => a.AccountID == accountId).ToList();
            foreach (var item in items)//先删除此用户所有的角色关系
            {
                db.AccountRoles.Remove(item);
            }
            db.SaveChanges();

            if (!(result.Count()==1 && result[0].RoleID==0))//如果没有取消此用户所有的角色关联
            {
                foreach (var item in result)//遍历接收到的用户-角色关系
                {                    
                    db.AccountRoles.Add(item);  //添加用户-角色关系
                }
                db.SaveChanges();
            }            
            //return View("AccountRole");
        }
        //角色-菜单授权:RoleMenu
        public ActionResult RoleMenu(int RoleID=0)
        {
            ViewBag.Roles = db.Roles.
                Where(r => RoleID == 0 || r.RoleID == RoleID).ToList();
            ViewBag.Menus = db.Menus.ToList();
            return View(db.RoleMenus.ToList());
        }
        [HttpPost]
        public void RoleMenu(string accountRoles)
        {
            //接受Ajax传过来的json数据并转化成集合
            var result = JsonConvert.DeserializeObject<List<RoleMenus>>(accountRoles);
            //获取当前用户ID
            int roleId = result[0].RoleID;
            //获取当前用户所有的角色关系
            var items = db.RoleMenus.Where(a => a.RoleID == roleId).ToList();
            foreach (var item in items)//先删除此用户所有的角色关系
            {
                db.RoleMenus.Remove(item);
            }
            db.SaveChanges();

            if (!(result.Count() == 1 && result[0].MenuID == 0))//如果没有取消此用户所有的角色关联
            {
                foreach (var item in result)//遍历接收到的用户-角色关系
                {
                    db.RoleMenus.Add(item);  //添加用户-角色关系
                }
                db.SaveChanges();
            }
            //return View();
        }
        public ActionResult Find()
        {
            ViewBag.Accounts = db.Account.ToList();
            return View(db.AccountMenus.ToList());
        }
    }
}