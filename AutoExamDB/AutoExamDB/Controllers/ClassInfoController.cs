using AutoExamDB.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class ClassInfoController : Controller
    {
        // GET: ClassInfo
        public ActionResult Index(/*int id=0*/)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                //if (id == 0)
                //{
                //    return View(db.ClassInfo.ToList());
                //}
                //else
                //{
                //    ClassInfo classInfo = db.ClassInfo.Find(id);
                //    return Json(classInfo, JsonRequestBehavior.AllowGet);
                //}
                return View(db.ClassInfo.ToList());
            }           
        }
        [HttpPost]
        public ActionResult Index(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                var classInfo = db.ClassInfo.Find(id);
                //使用Newtonsoft.Json库把对象转化成json
                //string json = JsonConvert.SerializeObject(classInfo);
               return Json(classInfo, JsonRequestBehavior.AllowGet);
               // return Content(json);
            }
        }
        public ActionResult Add(ClassInfo classInfo)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.ClassInfo.Add(classInfo);
                db.SaveChanges();
                return RedirectToAction("Index", "ClassInfo");
            }
        }
        public ActionResult Edit(ClassInfo classInfo)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                db.Entry(classInfo).State= System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "ClassInfo");
            }
        }
        public ActionResult Dele(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                ClassInfo classInfo = new ClassInfo();
                classInfo.ClassInfoID = id;
                db.Entry(classInfo).State = System.Data.Entity.EntityState.Deleted;
                db.SaveChanges();
                return RedirectToAction("Index", "ClassInfo");
            }
        }
    }
}