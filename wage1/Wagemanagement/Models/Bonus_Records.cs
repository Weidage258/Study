//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace Wagemanagement.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Bonus_Records
    {
        public int BR_id { get; set; }
        public int Staff_id { get; set; }
        public int Bonus_Id { get; set; }
        public System.DateTime CR_date { get; set; }
        [Newtonsoft.Json.JsonIgnore]
        public virtual Bonus Bonus { get; set; }
        [Newtonsoft.Json.JsonIgnore]
        public virtual Staff Staff { get; set; }
    }
}
