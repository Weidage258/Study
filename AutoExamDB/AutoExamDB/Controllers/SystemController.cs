using AutoExamDB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoExamDB.Controllers
{
    public class SystemController : Controller
    {
        // GET: System
        public ActionResult Index(int id)
        {
            using (AutoExamDBEntities db = new AutoExamDBEntities())
            {
                return View(db.Menus.Where(m=>m.Pid==id).ToList());
            }
        }
    }
}