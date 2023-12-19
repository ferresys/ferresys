import nodemailer from 'nodemailer';
import dotenv from 'dotenv';

dotenv.config();

export async function sendConfirmationEmail(user) {
    const smtpTransport = nodemailer.createTransport({
        host: 'smtp.mailtrap.io',
        port: 2525,
        auth: {
            user: process.env.MAILTRAP_USER,
            pass: process.env.MAILTRAP_PASS,
        },
    });

    const mailOptions = {
        from: process.env.EMAIL,
        to: user.correo,
        subject: 'Confirma tu cuenta',
        html: `
        <!DOCTYPE html PUBLIC>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <style type="text/css">
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProLight.otf");
            font-weight: 300;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProLightItalic.otf");
            font-weight: 300;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
            font-weight: normal;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
            font-weight: normal;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProMedium.otf");
            font-weight: 500;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProMediumItalic.otf");
            font-weight: 500;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProBold.otf");
            font-weight: 600;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProBoldItalic.otf");
            font-weight: 600;
            font-style: italic;
        }
    </style>
    <!--[if (gte mso 9)|(IE)]> <style type="text/css"> table{border-collapse: collapse;}</style><![endif]-->
</head>

<body style="Margin: 0; background-color: #ffffff !important; color: #2D444E; font-family: Arial,sans-serif; font-size: 14px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
    <center class="wrapper" style="-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; table-layout: fixed; width: 100%;">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
            <tr>
                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
            </tr>
        </table>
        <div class="webkit" style="margin: 0 auto; max-width: 600px;">
            <!--[if (gte mso 9)|(IE)]> <table width="600" align="center"> <tr> <td><![endif]-->
            <table class="outer" align="center" style="Margin: 0 auto; border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif; max-width: 600px; width: 100%;">
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td align="center" valign="top" style="padding: 0;">
                                    <a href="" target="_blank" style="Margin: 0; color: #9DD6EA; font-family: Arial,sans-serif; font-weight: normal; line-height: 1.3; margin: 0 !important; padding:
0; text-decoration: underline;"><img src="https://drive.google.com/uc?id=1bSDI-0PONIf4_600TP4cbArpJjotXSUm" width="200" height="200" border="0" alt="Heaven Sent" style="border: none; display: block; height: 100px !important; margin: 0; padding: 0; width: 100px !important;"></a>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table class="content" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#f9f9f9" style="-moz-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); -webkit-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); background-color: #f9f9f9; border-collapse: separate !important; border-color: #e4e2e2; border-radius: 4px; border-spacing: 0; border-style: solid; border-width: 1px; box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td align="center" valign="top" style="padding: 0;">
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="35" style="font-size: 35px; line-height: 35px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td class="inner" align="center" valign="top" style="padding: 0px 10px;">
                                                <p class="h1" style="Margin:
0; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 25px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">Hola, ${user.nombre}</p><br/><br/>
                                              <p style="margin-left: auto; margin-right: auto; width: 80%; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
                                                Por favor confirme su cuenta, haciendo clic aqui

                                              </p>
                                              <br/><br/>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="15" style="font-size: 15px; line-height: 15px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td class="padding-0-30" align="center" valign="top" style="padding: 0 30px;">
                                                
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="10" style="font-size: 10px;
line-height: 10px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table class="content__button" width="190" height="48" cellpadding="0" cellspacing="0" border="0" bgcolor="#022232" style="background-color: #022232; border-radius: 3px; border-spacing: 0; color: #ffffff !important; font-family: Arial,sans-serif; height: 48px; padding: 0 15px;">
                                        <tr>
                                          <!-- LINK DE 
END -->
                                            <td align="center" valign="middle" height="48" style="color: #ffffff !important; padding: 0;"> <a class="content__button-link" href="http://localhost:4000/api/auth/confirm/${user.confirmationCode}" target="_blank" style="Margin: 0; color: #ffffff !important; display: inline-block; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 20px; font-weight: 600; line-height: 48px; margin: 0 !important; padding: 0; text-decoration: none;">Confirmar Cuenta</a>                                                </td>
                                            <!-- FIN LINK DE BACKEND -->
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td class="inner header__text" align="center" valign="top" style="color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; padding: 0px 10px; text-decoration: none;">
                                    <a class="header__link"  target="_blank" style="Margin: 0; color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; line-height: 1.3; margin: 0 !important; padding: 0; text-decoration: none;">&copy;&nbsp;2024&nbsp;FerreSys&nbsp;</a>                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!--[if (gte mso 9)|(IE)]> </td></tr></table><![endif]-->
        </div>
    </center>
</body>

</html>
    `
    };

    smtpTransport.sendMail(mailOptions, (error, response) => {
        error ? console.log(error) : console.log(response);
        smtpTransport.close();
    });
}


export async function sendResetPasswordEmail(user, token) {
    const smtpTransport = nodemailer.createTransport({
        host: 'smtp.mailtrap.io',
        port: 2525,
        auth: {
            user: process.env.MAILTRAP_USER,
            pass: process.env.MAILTRAP_PASS,
        },
    });

    if (!user.correo) {
        console.log('No email provided for user', user);
        return;
    }

    const mailOptions = {
        from: process.env.EMAIL,
        to: user.correo,
        subject: 'Restablece tu contraseña',
        html: `
        <!DOCTYPE html PUBLIC>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <style type="text/css">
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProLight.otf");
            font-weight: 300;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProLightItalic.otf");
            font-weight: 300;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
            font-weight: normal;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
            font-weight: normal;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProMedium.otf");
            font-weight: 500;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProMediumItalic.otf");
            font-weight: 500;
            font-style: italic;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProBold.otf");
            font-weight: 600;
            font-style: normal;
        }
        
        @font-face {
            font-family: "Gotham";
            src: url("http://app.mydoctorize.com/fonts/GothamProBoldItalic.otf");
            font-weight: 600;
            font-style: italic;
        }
    </style>
    <!--[if (gte mso 9)|(IE)]> <style type="text/css"> table{border-collapse: collapse;}</style><![endif]-->
</head>

<body style="Margin: 0; background-color: #ffffff !important; color: #2D444E; font-family: Arial,sans-serif; font-size: 14px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
    <center class="wrapper" style="-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; table-layout: fixed; width: 100%;">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
            <tr>
                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
            </tr>
        </table>
        <div class="webkit" style="margin: 0 auto; max-width: 600px;">
            <!--[if (gte mso 9)|(IE)]> <table width="600" align="center"> <tr> <td><![endif]-->
            <table class="outer" align="center" style="Margin: 0 auto; border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif; max-width: 600px; width: 100%;">
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td align="center" valign="top" style="padding: 0;">
                                    <a href="" target="_blank" style="Margin: 0; color: #9DD6EA; font-family: Arial,sans-serif; font-weight: normal; line-height: 1.3; margin: 0 !important; padding:
0; text-decoration: underline;"><img src="https://drive.google.com/uc?id=1bSDI-0PONIf4_600TP4cbArpJjotXSUm" width="200" height="200" border="0" alt="Heaven Sent" style="border: none; display: block; height: 100px !important; margin: 0; padding: 0; width: 100px !important;"></a>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table class="content" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#f9f9f9" style="-moz-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); -webkit-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); background-color: #f9f9f9; border-collapse: separate !important; border-color: #e4e2e2; border-radius: 4px; border-spacing: 0; border-style: solid; border-width: 1px; box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td align="center" valign="top" style="padding: 0;">
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="35" style="font-size: 35px; line-height: 35px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td class="inner" align="center" valign="top" style="padding: 0px 10px;">
                                                <p class="h1" style="Margin:
0; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 25px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">Hola, ${user.nombre} </p><br/><br/>
                                              <p style="margin-left: auto; margin-right: auto; width: 80%; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
                                              Recibimos una solicitud para restablecer tu contraseña.Puedes hacerlo haciendo clic en el siguiente botón:

                                              </p>
                                              <br/><br/>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="15" style="font-size: 15px; line-height: 15px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td class="padding-0-30" align="center" valign="top" style="padding: 0 30px;">
                                                
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="10" style="font-size: 10px;
line-height: 10px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table class="content__button" width="190" height="48" cellpadding="0" cellspacing="0" border="0" bgcolor="#022232" style="background-color: #022232; border-radius: 3px; border-spacing: 0; color: #ffcc29 !important; font-family: Arial,sans-serif; height: 48px; padding: 0 15px;">
                                        <tr>
                                          <!-- LINK DE 
END -->
                                            <td align="center" valign="middle" height="48" style="color: #ffffff !important; padding: 0;"> <a class="content__button-link" href="http://localhost:4000/public/resetpass.html?token=${token}" target="_blank" style="Margin: 0; color: #ffffff !important; display: inline-block; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 20px; font-weight: 600; line-height: 48px; margin: 0 !important; padding: 0; text-decoration: none;">Restablecer Contraseña</a>                                                </td>
                                            <!-- FIN LINK DE BACKEND -->
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                        <tr>
                                            <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="inner" style="padding: 0px 10px;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td class="inner header__text" align="center" valign="top" style="color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; padding: 0px 10px; text-decoration: none;">
                                    <a class="header__link"  target="_blank" style="Margin: 0; color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; line-height: 1.3; margin: 0 !important; padding: 0; text-decoration: none;">&copy;&nbsp;2024&nbsp;FerreSys&nbsp;</a>                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                            <tr>
                                <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!--[if (gte mso 9)|(IE)]> </td></tr></table><![endif]-->
        </div>
    </center>
</body>

</html>
    `
    };

    console.log('About to send reset password email');

    smtpTransport.sendMail(mailOptions, (error, response) => {
        if (error) {
            console.log('Error sending reset password email', error);
        } else {
            console.log('Reset password email sent', response);
        }
        smtpTransport.close();
    });

    console.log('Done with sendResetPasswordEmail');
}