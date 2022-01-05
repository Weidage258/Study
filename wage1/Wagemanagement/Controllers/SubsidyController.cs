using Newtonsoft.Json;
using System.Linq;
using System.Web.Mvc;
using Wagemanagement.Models;

namespace Wagemanagement.Controllers
{
    public class SubsidyController : Controller
    {
        // GET: Subsidy
        public ActionResult SubsidyIndex()
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var sub = db.Subsidy.ToList();
                return View(sub);
            }

        }
        //查询
        public string SubSet(int page, int limit)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                var data = db.Subsidy.ToList();

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
        public bool SubSel(int id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Subsidy.Find(id);
                db.Subsidy.Remove(data);
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
        public ActionResult EditSub(int? id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var Sub = db.Subsidy.Find(id);
                return View(Sub);
            }
        }
        //更新修改表数据
        public bool UpdateSub(Subsidy subsidy)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var b = db.Subsidy.Find(subsidy.Subsidy_id);
                b.Subsidy_Name = subsidy.Subsidy_Name;
                b.Subsidy_pirce= subsidy.Subsidy_pirce;

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }
        }
        [HttpPost]
        //模糊查询奖金名数据
        public string SubSelect(int page, int limit, string Subsidy_Name)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                var data = db.Subsidy.Where(p => p.Subsidy_Name.Contains(Subsidy_Name)).ToList();

                var data2 = data.Skip((page - 1) * limit).Take(limit).ToList();
                var d = new { code = 0, msg = "", count = data.Count, data = data2 };

                return JsonConvert.SerializeObject(d);
            }

        }
        //添加表试图
        public ActionResult AddSub()
        {
            return View();
        }
        //UpdateSubData
        [HttpPost]
        //添加表数据
        public bool UpdateSubData(Subsidy subsidy)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {
                Subsidy b = new Subsidy
                {
                    Subsidy_Name = subsidy.Subsidy_Name,
                    Subsidy_pirce = subsidy.Subsidy_pirce
                };
                db.Subsidy.Add(b);

                if (db.SaveChanges() > 0)
                {
                    return true;
                }
                return false;
            }


        }
        //批量删除
        [HttpPost]
        public JsonResult Remove(string[] Subsidy_id)
        {
            using (WagemanagementEntities db = new WagemanagementEntities())
            {

                foreach (var item in Subsidy_id)
                {
                    int daa = int.Parse(item);
                    var da = db.Subsidy.FirstOrDefault(c => c.Subsidy_id == daa);

                    db.Subsidy.Remove(da);
                }
                db.SaveChanges();
                return Json(new { state = 10000 });
            }
        }
    
    }
}