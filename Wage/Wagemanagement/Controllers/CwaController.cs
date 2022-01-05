using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class CwaController : Controller
    {
        // GET: Cwa
        public ActionResult CwaIndex()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var cwa = db.Cwa.ToList();
                return View(cwa);
            }

        }
        public string CwaSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Cwa.ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new
                {
                    code = "0",
                    msg = ""
                    ,
                    count = data.Count
                    ,
                    data = data2
                };

                return JsonConvert.SerializeObject(d);
            }

        }
        //奖金删除表
        [HttpPost]
        public bool CwaSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Cwa.Find(id);
                db.Cwa.Remove(data);
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

        }

        //修改表试图
        public ActionResult EditCwa(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Cwa.Find(id);
                return View(b);
            }
        }
        //更新修改表数据
        public bool UpdateCwa(Cwa cwa)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Cwa.Find(cwa.Cwa_id);
                b.Cwa_Name = cwa.Cwa_Name;
                b.Cwa_pirce = cwa.Cwa_pirce;

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        [HttpPost]
        //模糊查询奖金名数据
        public string CwaSelect(int page, int limit, string Cwa_Name)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Cwa.Where(p => p.Cwa_Name.Contains(Cwa_Name)).ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };

                return JsonConvert.SerializeObject(d);
            }

        }
        //添加表试图
        public ActionResult AddCwa()
        {
            return View();
        }
        [HttpPost]
        //添加表数据
        public bool UpdateCwaData(Cwa cwa)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                Cwa b = new Cwa
                {
                    Cwa_Name = cwa.Cwa_Name,
                    Cwa_pirce = cwa.Cwa_pirce
                };
                db.Cwa.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
        //批量删除
        [HttpPost]
        public JsonResult Remove(string[] Cwa_id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in Cwa_id)
                {
                    int daa = int.Parse(item);
                    var da = db.Cwa.FirstOrDefault(c => c.Cwa_id == daa);
                    
                    db.Cwa.Remove(da);
                }
                db.SaveChanges();
                return Json(new { state = 10000 });
            }
        }
        //UpdateCwaR
        //更新修改表数据
        public bool UpdateCwaR(Cwa_Rd_View cwa_Rd_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Cwa.FirstOrDefault(p => p.Cwa_Name== cwa_Rd_View.Cwa_Name);

                var b = db.Cwa_Records.Find(cwa_Rd_View.CR_id);
                b.Staff_id = cwa_Rd_View.Staff_id;
                b.Cwa_id = jiang.Cwa_id;
                b.CR_date = cwa_Rd_View.CR_date;
                b.CR_Frequency = cwa_Rd_View.CR_Frequency;
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
    }
}