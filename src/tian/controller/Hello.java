package tian.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import tian.dao.TypeDao;
import tian.dao.UserDao;
import tian.table.Type;
import tian.table.User;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.List;

@Controller
@Scope("prototype")
@Transactional
public class Hello{
    @Resource
    private UserDao userDao;

    @Resource
    private TypeDao typeDao;
    private String code = "";

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, Model model) {
        request.getSession().setAttribute("user",null);
        List<Type> types = typeDao.findAll();
        model.addAttribute("types", types);
        return "index";
    }

    @RequestMapping(value = "/check")
    public void check(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = response.getWriter();
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String code = request.getParameter("code").toUpperCase();
        String oCode = code.toLowerCase();
        HttpSession session = request.getSession();
        String verify = (String) session.getAttribute("code");

        if (!(verify.equals(code) || verify.equals(oCode))) {
            printWriter.print("1");

        } else {
            List<User> users = userDao.findByName(user);
            if (users.size() < 1) {
                printWriter.print("2");

            } else {
                if (users.get(0).getPass().equals(pass)) {
                    User user1 = users.get(0);

                    session.setAttribute("user", user1);
                    printWriter.print("3");


                } else {
                    printWriter.print("4");

                }
            }
        }


    }

    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    public void reg(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("user");
        List<User> users = userDao.findByName(username);
        if (users.size() > 0) {
            response.getWriter().print("0");
        } else {
            String pass = request.getParameter("pass");


            User user = new User();
            user.setName(username);
            user.setPass(pass);
            user.setUserType(1);
            userDao.save(user);


            response.getWriter().print("1");
        }
    }

    @RequestMapping(value = "/my")
    public String my(HttpServletRequest request, Model model) {

        return "my";

    }

    @RequestMapping(value = "/ww")
    public void image(HttpServletRequest request, HttpServletResponse resp) throws IOException {
        BufferedImage image = setImage();
        HttpSession session = request.getSession();
        session.setAttribute("code", code);
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        resp.setContentType("image/jpeg");
        ServletOutputStream sos = resp.getOutputStream();
        ImageIO.write(image, "jpeg", sos);
        sos.close();
    }

    public BufferedImage setImage() {
        BufferedImage image = new BufferedImage(150, 70, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        Graphics2D g2d = (Graphics2D)g;
        Font mFont = new Font("΢���ź�", Font.BOLD, 20);
        g.setColor(new Color(139, 163, 198));
        g.fillRect(0, 0, 150, 70);
        BasicStroke bs = new BasicStroke(2f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL);
        g2d.setStroke(bs);

        g.setColor(new Color(111, 128, 207));  //���õ�ǰ��ɫΪԤ������ɫ�е����ɫ
        int[] xPoints = new int[3];
        int[] yPoints = new int[3];
        Random random = new Random();
        for (int j = 0; j < 3; j++) {
            xPoints[j] = random.nextInt(150 - 1);
            yPoints[j] = random.nextInt(70 - 1);
        }
        g.drawPolyline(xPoints, yPoints, 3);
        g.setFont(mFont);
        int itmp = 0;
        for (int i = 0; i < 4; i++) {
            if (random.nextInt(2) == 1) {
                itmp = random.nextInt(26) + 65; //����A~Z����ĸ
            } else {
                itmp = random.nextInt(10) + 48; //����0~9������
            }
            char ctmp = (char) itmp;
            code += String.valueOf(ctmp);
            int a = 0;
            int b = 0;
            int c = 0;
            switch (i) {
                case 0:
                    a = 17;
                    b = 50;
                    c = 76;
                    break;
                case 1:
                    a = 137;
                    b = 0;
                    c = 142;
                    break;
                case 2:
                    a = 9;
                    b = 192;
                    c = 5;
                    break;
                case 3:
                    a = 255;
                    b = 254;
                    c = 242;
                    break;
            }
            g.setColor(new Color(a, b, c));
            /****����������ֲ���������תָ���Ƕ�**/
            //��������תָ���Ƕ�
            Graphics2D g2d_word = (Graphics2D) g;
            AffineTransform trans = new AffineTransform();
            trans.rotate(random.nextInt(45) * 3.14 / 180, 15 * i + 10, 7);
            //��������
            float scaleSize = random.nextFloat() + 0.8f;
            if (scaleSize > 1.1f) scaleSize = 1f;
            trans.scale(scaleSize, scaleSize);
            g2d_word.setTransform(trans);

            g.drawString(String.valueOf(ctmp), 30 * i + 40, 16);
        }

        return image;
    }
    @RequestMapping(value = "/editInf")
    public void editInf(HttpServletRequest request,HttpServletResponse response)throws IOException{
        String telephone=request.getParameter("telephone");
        String address=request.getParameter("address");
        Long id=((User)request.getSession().getAttribute("user")).getId();
        User user=userDao.getById(id);
        user.setTelNum(telephone);
        user.setAddress(address);
        userDao.update(user);
        request.getSession().setAttribute("user",user);
        System.out.print(telephone+"||"+address);
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/getEditInfo")
    public String addTypePage() {
        return "editInfo";
    }


}
