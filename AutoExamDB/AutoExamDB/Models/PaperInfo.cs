//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace AutoExamDB.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PaperInfo
    {
        public int PaperInfoID { get; set; }
        public int PaperID { get; set; }
        public int TopicID { get; set; }
        public int TopicScore { get; set; }
    
        public virtual Paper Paper { get; set; }
        public virtual Topic Topic { get; set; }
    }
}