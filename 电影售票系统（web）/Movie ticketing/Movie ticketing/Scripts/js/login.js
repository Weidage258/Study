
    //昵称
                function DoUserNickName() {
                    var nickname = $("#UserNickname").val();
                    if (nickname == "") {
        $("#nick").html("昵称不能为空");
                    }
                    else if (nickname.length > 20) {
        $("#nick").html("昵称不能超出20位");
                    }
                    else {
        $("#nick").html("");
                    }
                }
                //注册用户
                function DoRegisterUserName() {
                    var yz = /^1[3,5,7,8,9]{1}[0-9]{9}$/;
                    var registerName = $("#RegisterUserName").val();
                    if (registerName == "")
                    {
        $("#registername").html("用户名不能为空");
                    }
                    else if (!yz.test(registerName))
                    {
        $("#registername").html("电话号码不正确");
                    }
                    else
                    {
        $("#registername").html("");
                    }

}
//清除类
function clearClass() {
    $("#bt1").removeClass("btn-warning");
    $("#bt2").removeClass("btn-warning");
    $("#bt3").removeClass("btn-warning");
}
                //密码
                function DoRegisterUserPwd() {
                    var regNumber = /\d+/; //验证0-9的任意数字最少出现1次。
                    var regString = /[a-zA-Z]+/; //验证大小写26个字母任意字母最少出现1次。
                    var yz = /^([a-zA-z0-9]{8,16})$/;
                    var pwd = $("#RegisterUserPwd").val();
                    if (pwd == "") {
                        $("#registerpwd").html("密码不能为空");
                        clearClass();
                    }
                    else if (!yz.test(pwd)) {
                        $("#registerpwd").html("密码只能由字母和数字组成的8~16位字符");
                        clearClass();
                    }
                    else
                    {
                         $("#registerpwd").html("");
                    }
                  //判断密码等级
                    if (yz.test(pwd)) {

                        if (regNumber.test(pwd) && regString.test(pwd) && pwd.length >10) {
                            $("#bt1").addClass("btn-warning");
                            $("#bt2").addClass("btn-warning");
                            $("#bt3").addClass("btn-warning");
                        }
                        else if (regNumber.test(pwd) && regString.test(pwd)) {
                            clearClass();
                            $("#bt1").addClass("btn-warning");
                            $("#bt2").addClass("btn-warning");
                        } else if (regNumber.test(pwd) || regString.test(pwd)) {
                            clearClass();
                            $("#bt1").addClass("btn-warning");
                        } 
                    }
                }
                //确认密码
                function DoRegisterUserPwd2() {
                    var pwd2 = $("#RegisterUserPwd2").val();
                    var pwd = $("#RegisterUserPwd").val();
                    if (pwd2 != pwd) {
        $("#registerpwd2").html("两次密码不一致");
                    } else {
        $("#registerpwd2").html("");
                    }
                }
