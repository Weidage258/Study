using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class RoleController : Controller
    {
        // GET: Role
        public ActionResult Index()
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                return View(db.Roles.ToList());
            }
            
        }
        public ActionResult Add()
        {            
            return View();
        }
        [HttpPost]
        public ActionResult Add(Roles roles)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.Roles.Add(roles);
                db.SaveChanges();
                return RedirectToAction("Index", "Role");
            }
        }
        public ActionResult Edit(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                return View(db.Roles.Find(id));
            }

        }
        [HttpPost]
        public ActionResult Edit(Roles roles)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.Entry(roles).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "Role");
            }
        }
        public ActionResult Dele(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                var roles = new Roles();
                roles.RoleID = id;
                db.Entry(roles).State = System.Data.Entity.EntityState.Deleted;
                db.SaveChanges();
                return RedirectToAction("Index", "Role");
            }
        }
    }
}