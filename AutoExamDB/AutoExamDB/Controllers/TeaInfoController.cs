using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class TeaInfoController : Controller
    {
        AutoExamDBEntities db = new AutoExamDBEntities();
        // GET: TeaInfo
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Info()
        {
            return PartialView(db.StuInfo.ToList());
        }
        public ActionResult Add()
        {
            return PartialView();
        }
        public ActionResult Edit()
        {
            return PartialView();
        }
        public ActionResult Dele()
        {
            return View();
        }
    }
}