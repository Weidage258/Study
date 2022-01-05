using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tool
{
    public class Alert
    {
        //弹出框
        public static string show(string text,string url)
        {
            string js = "$('.alert').html('"+text+"').addClass('alert-success')." +
                "show().delay(500).fadeOut();" +
                "var num = 1; var URL = '"+url+"';" +
                " var id = window.setInterval('doUpdate()', 500);" +
                "function doUpdate() {" +
                " if(num == 0) {" +
                "  window.clearInterval(id);" +
                "  window.location = URL;}" +
                "num --; }";
            return js;
        }
    }
}
