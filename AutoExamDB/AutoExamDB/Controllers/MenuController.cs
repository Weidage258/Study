using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class MenuController : Controller
    {
        // GET: Menu
        public ActionResult Index()
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                //Session["Menus"] = db.Menus.ToList();//更新会话密钥
                return View(db.Menus.ToList());
            }
            
        }
        public ActionResult Add(int id,string menuname, int typeid)
        {
            ViewBag.MenuName = menuname;
            var model = new Menus() {
                Name = null,
                Url = null,
                Pid = id,
                Remark = null,
                IsMenu = typeid == 3 ? false : true,
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Add(Menus menus)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.Menus.Add(menus);
                db.SaveChanges();
                return RedirectToAction("Index", "Menu");
            }
        }
        public ActionResult Edit(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                return View( db.Menus.Find(id));
            }
            
        }
        [HttpPost]
        public ActionResult Edit(Menus menus)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.Entry(menus).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "Menu");
            }
        }
        public ActionResult Dele(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                var menus = new Menus();
                menus.MenuID = id;
                db.Entry(menus).State = System.Data.Entity.EntityState.Deleted;
                db.SaveChanges();
                return RedirectToAction("Index", "Menu");
            }
        }
    }
}