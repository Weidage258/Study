<%@ Page Title="" Language="C#" MasterPageFile="~/movie.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Movie_ticketing.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        *{
            margin:0;
            padding:0;
        }
        #content{
            border:1px solid black;
            height:auto;
            width:1200px;
            margin:62px auto;
            display:flex;
        }
        #left{
            width:750px;
            border:1px solid red;
        }
        #right{
            margin-left:90px;
            width:360px;
            border:1px solid blue;
        }    
        #hotTitle{
            color:#ef4238;
        }
        #hotall{
            font-size:14px;
            margin-left:490px;
        }
        #hotall a{
            color:#ef4238;
        }
        #hotMovieList{
            margin-top:23px;
            height:569px;
            border:1px solid green;
        }
        .hotName{
            position:absolute;
            bottom:3px;
            color:white;
            left:10px;
        }
        #imga{
            display:inline-block;
            position:relative;
            width:160px;
            height:214px;
        }
        #imga img{
            position:absolute;
        }
        .movieimage{
            top:0px;
        }
        .heiyin{
            top:140px;
        }
        .font1{
            color: yellow;
            font-style: italic;
            position: absolute;
            top: 183px;
            right: 13px;
            font-size: 20px;
        }
        .font2{
            color: yellow;
            position: absolute;
            top: 190px;
            right: 5px;
            font-style: italic;
            font-size: 14px;
        }
       .col .shop{
            border:1px solid #efefef;
            width: 160px;
            height: 38px;
            display: inline-block;
            margin-bottom: 30px;
            text-align:center;
            line-height:38px;
            color:dodgerblue;
        }
       .zhong{
            width:750px;
            border:1px solid red;
              margin: auto;
       }
    </style>
    <div id="content">
        <div id="left">
            <div>
                <div id="hotTitle">
                    <span style="font-size:26px;">正在热映（8部）</span>
                    <span id="hotall">
                        <a href="#">全部</a>
                        <svg style="margin-top:-4px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
                        </svg>
                    </span>
                </div>
                <div id="hotMovieList">
                    <asp:DataList ID="HotMovieList" runat="server" RepeatColumns="4">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col" style="margin-left:-3.5px;">
                                                <a href="#" id="imga">
                                                    <img src="<%#Eval("MovieImage") %>" class="movieimage"/>
                                                    <img src="images/素材/阴影.jpg" class="heiyin"/>
                                                    <span class="hotName" title="<%#Eval("moviename") %>">
                                                        <%-- 当电影名长度大于7，则只取前6位，鼠标悬浮到span时显示全名 --%>
                                                        <%#Eval("moviename").ToString().Length>7 ?Eval("                                                                                                  moviename").ToString().Substring(0,6)+"...":Eval("moviename")%>
                                                    </span>
                                                    <span class="font1"><%#Eval("score").ToString().Substring(0,1) %>.</span>
                                                    <span class="font2"><%#Eval("score").ToString().Substring(2,1) %></span>
                                                </a>
                                                <a class="shop ">购票</a>
                                            </div>

                                        </div>
                                    </div>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>
        <div id="right">
              <div id="hotMovieList">
                    <asp:DataList ID="DataList2" runat="server" RepeatColumns="1">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <div class="">
                                        <div class="row">
                                            <div class="col" style="margin-left:-3.5px;">
                                                <a href="#" id="imga">
                                                    <img src="<%#Eval("MovieImage") %>" class="movieimage"/>
                                                                                                  
                                                </a>
                                             
                                            </div>

                                        </div>
                                    </div>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
        </div>
         
    </div>
   <div class="zhong">
               <asp:DataList ID="DataList1" runat="server" RepeatColumns="4">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col" style="margin-left:-3.5px;">
                                                <a href="#" id="imga">
                                                    <img src="<%#Eval("MovieImage") %>" class="movieimage"/>
                                                    <img src="images/素材/阴影.jpg" class="heiyin"/>
                                                    <span class="hotName" title="<%#Eval("moviename") %>">
                                                        <%-- 当电影名长度大于7，则只取前6位，鼠标悬浮到span时显示全名 --%>
                                                        <%#Eval("moviename").ToString().Length>7 ?Eval("                                                                                                  moviename").ToString().Substring(0,6)+"...":Eval("moviename")%>
                                                    </span>
                                                    <span class="font1"><%#Eval("score").ToString().Substring(0,1) %>.</span>
                                                    <span class="font2"><%#Eval("score").ToString().Substring(2,1) %></span>
                                                </a>
                                                <a class="shop ">购票</a>
                                            </div>

                                        </div>
                                    </div>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
         </div>
</asp:Content>
