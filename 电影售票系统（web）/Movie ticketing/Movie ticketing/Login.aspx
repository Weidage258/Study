<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Movie_ticketing.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <script src="Scripts/vue.min.js"></script>
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="Content/alert.css"/>
    <style>
        body {
            margin: 0px;
            padding: 0px;
        }

        .left {
            width: 50%;
        }

        .regiht {
            width: 50%;
        }
    </style>
</head>
<body>
    <div class="alert"></div>
    <form id="form1" runat="server">
        <div style="display: flex; justify-content: flex-start; flex-wrap: wrap; flex-direction: row;">
            <div class="left">
                <img src="images/login/第一电影3.jpg"/style="margin-top:20px;margin-left:240px;width:220px;height:80px;"/>
                <img src="images/login/3.jpg"/ style="margin-left:350px;margin-top:-18px;"/>      
            </div>
            <div class="regiht" id="app">
                <div style="margin-top: 180px; margin-left: 100px;">
                    <div v-show="ok">
                        <b>账号登录</b>
                        <br />
                        <div style="display: flex;">
                            <span style="margin-top: 15px;">
                                <button type="button" class="btn btn-light"
                                    style="margin-top: -5.5px; border-bottom-right-radius: 0; border-top-right-radius: 0; padding-top: -1px;">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
                                    </svg>
                                </button>
                            </span>
                            <asp:TextBox ID="UserName" runat="server" placeholder="用户名/手机号" class="form-control " Style="width: 200px; margin-top: 10px;" ValidationGroup="login"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="用户名不能为空" ForeColor="Red" ValidationGroup="login"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="UserName" ErrorMessage="电话号码不正确" ForeColor="Red" ValidationExpression="^1[3,5,6,7,8,9]{1}[0-9]{9}" ValidationGroup="login"></asp:RegularExpressionValidator>

                        <br />
                        <div style="display: flex;">
                            <span style="margin-top: 15px;">
                                <button type="button" class="btn btn-light"
                                    style="margin-top: -18px; border-bottom-right-radius: 0; border-top-right-radius: 0; padding-top: -1px;">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-lock2-fill" viewBox="0 0 16 16">
                                        <path d="M7 7a1 1 0 0 1 2 0v1H7V7z" />
                                        <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zM10 7v1.076c.54.166 1 .597 1 1.224v2.4c0 .816-.781 1.3-1.5 1.3h-3c-.719 0-1.5-.484-1.5-1.3V9.3c0-.627.46-1.058 1-1.224V7a2 2 0 1 1 4 0z" />
                                    </svg>
                                </button>

                            </span>
                            <asp:TextBox ID="UserPwd" runat="server" placeholder="密码" class="form-control" Style="width: 200px;" TextMode="Password" ValidationGroup="login"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserPwd" ErrorMessage="密码不能为空" ForeColor="Red" ValidationGroup="login"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="UserPwd" ErrorMessage="密码只能由字母和数字组成的8~16位字符" ForeColor="Red" ValidationExpression="^([a-zA-z0-9]{8,16})$" ValidationGroup="login"></asp:RegularExpressionValidator>
                        <br />
                        <a href="#" class="text-danger" style="text-decoration: none; margin-left: 135px;">忘记密码？</a>
                        <br />
                        <asp:Button ID="Button1" runat="server" Text="登录" class="btn btn-primary btn-sm" Style="width: 245px; margin-top: 10px; margin-bottom: 10px;" ValidationGroup="login" OnClick="Button1_Click" />
                        <br />
                        还没有账号？<span class="text-danger" style="text-decoration: none;" @click="dochange">免费注册</span>
                    </div>
                    <div v-if="ok2">
                        <b>用户注册</b><br />
                        <asp:TextBox ID="UserNickname" runat="server" placeholder="昵称" class="form-control" onblur="DoUserNickName();" Style="width: 200px; margin-top: 10px;"></asp:TextBox>
                        <span id="nick" style="color: red;"></span>
                        <br />
                        <asp:TextBox ID="RegisterUserName" runat="server" placeholder="用户名/手机号" class="form-control" onblur="DoRegisterUserName()" Style="width: 200px;"></asp:TextBox>
                        <span id="registername" style="color: red;"></span>
                        <br />
                        <div style="display: flex">
                            <asp:TextBox ID="RegisterUserPwd" runat="server" placeholder="密码" class="form-control" onblur="DoRegisterUserPwd()" Style="width: 200px;"></asp:TextBox>
                            <span style="font-size: 3px; color: coral; margin-top: -20px;">账号密码安全系数</span>
                            <div class="btn-group" role="group" aria-label="Basic example" style="margin-left: -95px;">
                                <button type="button" class="btn " id="bt1" style="color: ghostwhite">低</button>
                                <button type="button" class="btn " id="bt2" style="color: ghostwhite">中</button>
                                <button type="button" class="btn " id="bt3" style="color: ghostwhite">高</button>
                            </div>
                        </div>
                        <span id="registerpwd" style="color: red;"></span>
                        <br />
                        <asp:TextBox ID="RegisterUserPwd2" runat="server" placeholder="确认密码" class="form-control" onblur="DoRegisterUserPwd2()" Style="width: 200px;"></asp:TextBox>
                        <span id="registerpwd2" style="color: red;"></span>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="Register" runat="server" CausesValidation="False" class="btn btn-primary btn-sm" Style="width: 200px; margin-top: 10px;" Text="注册" OnClick="Register_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </div>
            </div>
        </div>
        <p style="color: lightgray; margin-left: 500px; font-size: 8px; margin-top: 30px;">
            ©2021 湖南工程职业技术学院 one.com 湘ICP证070791号 湘公网安备11010502025545号
        </p>
        <script src="Scripts/js/login.js"></script>
        <script>
            var vm = new Vue({
                el: "#app",
                data() {
                    return {
                        ok: true,
                        ok2: false,
                    }
                },
                methods: {
                    dochange() {
                        this.ok = false;
                        this.ok2 = true;
                    }
                }
            })
        </script>
        
    </form> 
</body>
</html>
