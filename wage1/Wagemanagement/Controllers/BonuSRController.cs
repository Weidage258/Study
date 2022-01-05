using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class BonuSRController : Controller
    {
        // GET: BonuSR
        public string BounsRSet(int page,int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Bonus_Rd_View.ToList();

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
        public bool BounsRSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Bonus_Records.Find(id);
                db.Bonus_Records.Remove(data);
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
        public ActionResult EditBonusR(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Bonus_Records.Find(id);
                var ok = b.Bonus_Id;
                ViewBag.info = db.Bonus.FirstOrDefault(c => c.Bonus_Id==ok).BonusName;
                ViewBag.info1 = db.Bonus.ToList();
                return View(b);
            }
        }
        //更新修改表数据
        public bool UpdateBonusR(Bonus_Rd_View bonus_Rd_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Bonus.FirstOrDefault(p => p.BonusName == bonus_Rd_View.BonusName);

                var b = db.Bonus_Records.Find(bonus_Rd_View.BR_id);
                b.Staff_id = bonus_Rd_View.Staff_id;
                b.Bonus_Id = jiang.Bonus_Id;
                b.CR_date = bonus_Rd_View.CR_date;
                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        //添加表试图
        public ActionResult AddBonusR()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                ViewBag.info1 = db.Bonus.ToList();
                return View();
            }
        }
        [HttpPost]
        //添加表数据
        public bool UpdateBonusDataR(Bonus_Rd_View bonus_Rd_View)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var jiang = db.Bonus.FirstOrDefault(p => p.BonusName == bonus_Rd_View.BonusName);
                Bonus_Records b = new Bonus_Records
                {
                    Staff_id = bonus_Rd_View.Staff_id,
                    Bonus_Id = jiang.Bonus_Id,
                    CR_date = DateTime.Today
                };
                db.Bonus_Records.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
        [HttpPost]
        //模糊查询奖金名数据
        public string BounsSelectS(int page, int limit, string BonusName,string Staff_id,string CR_date)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Bonus_Rd_View.Where(p => p.BonusName.Contains(BonusName) && p.Staff_id.ToString().Contains(Staff_id) && p.CR_date.ToString().Contains(CR_date)).ToList();
                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };
                return JsonConvert.SerializeObject(d);
            }
        }
        [HttpPost]
        public JsonResult RemoveS(string[] id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in id)
                {
                    int BR_id = int.Parse(item);
                    var da = db.Bonus_Records.FirstOrDefault(c => c.BR_id == BR_id);

                    db.Bonus_Records.Remove(da);
                }
                if (db.SaveChanges()>0)
                {
                    return Json(new { state = 10000 });
                }
                ;
                return Json(new { state = 100020 });
            }
        }
    }
}