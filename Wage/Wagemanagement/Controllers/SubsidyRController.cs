using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class SubsidyRController : Controller
    {
        // GET: SubsidyR
        public string SubRSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Subsidy_View.ToList();

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
        //BounsRSel
        //奖金删除表
        [HttpPost]
        public bool SubRSet(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Subsidy_Records.Find(id);
                db.Subsidy_Records.Remove(data);
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
        public ActionResult EditSubR(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Subsidy_Records.Find(id);
                var Subsidy_id = b.Subsidy_id;
                ViewBag.info = db.Subsidy.FirstOrDefault(c => c.Subsidy_id == Subsidy_id).Subsidy_Name;
                ViewBag.info1 = db.Subsidy.ToList();
                return View(b);
            }
        }
        //UpdateCwaR
        //更新修改表数据
        public bool UpdateSubR(Subsidy_View subsidy_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Subsidy.FirstOrDefault(p => p.Subsidy_Name == subsidy_View.Subsidy_Name);

                var b = db.Subsidy_Records.Find(subsidy_View.SR_Id);
                b.Staff_id = subsidy_View.Staff_id;
                b.Subsidy_id = jiang.Subsidy_id;
                b.SR_date = subsidy_View.SR_date;
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        //CwaSelectS
        [HttpPost]


        //模糊查询奖金名数据
        public string SubSelectS(int page, int limit, string Subsidy_Name, string Staff_id, string SR_date)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Subsidy_View.Where(p => p.Subsidy_Name.Contains(Subsidy_Name) && p.Staff_id.ToString().Contains(Staff_id) && p.SR_date.ToString().Contains(SR_date)).ToList();
                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };
                return JsonConvert.SerializeObject(d);
            }
        }
        //添加表试图
        public ActionResult AddSubR()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                ViewBag.info1 = db.Subsidy.ToList();
                return View();
            }
        }
        //添加表数据
        public bool UpdateSubDataR(Subsidy_View subsidy_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Subsidy.FirstOrDefault(p => p.Subsidy_Name == subsidy_View.Subsidy_Name);
                Subsidy_Records b = new Subsidy_Records
                {
                    Staff_id = subsidy_View.Staff_id,
                   Subsidy_id  = jiang.Subsidy_id,
                    SR_date = DateTime.Today
                };
                db.Subsidy_Records.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
        [HttpPost]
        public JsonResult RemoveS(string[] id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in id)
                {
                    int SR_Id = int.Parse(item);
                    var da = db.Subsidy_Records.FirstOrDefault(c => c.SR_Id == SR_Id);

                    db.Subsidy_Records.Remove(da);
                }
                if (db.SaveChanges() > 0)
                {
                    return Json(new { state = 10000 });
                }
                ;
                return Json(new { state = 100020 });
            }
        }
    }
}