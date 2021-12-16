package tian.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tian.dao.RecordDao;
import tian.dao.UserDao;
import tian.table.Record;
import tian.table.User;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@Scope("prototype")
@Transactional
public class Sell{
    @Resource
    private RecordDao recordDao;
    @Resource
    private UserDao userDao;

    @RequestMapping(value = "/shoppingCert")
    public void shoppingCert(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String itId = request.getParameter("itemId");

        Long itemId = Long.parseLong(itId);

        String select = request.getParameter("select");
        String price = request.getParameter("price");
        Long userId = ((User) request.getSession().getAttribute("user")).getId();

        int itemNum = Integer.parseInt(request.getParameter("number"));
        System.out.print("|" + select + ";" + price + ";" + itemNum + ";" + itId + "|");
        Record record = new Record();
        record.setUserId(userId);
        record.setItemId(itemId);
        record.setItemState(0);
        record.setSelType(select + "-" + price);
        record.setSelNumber(itemNum);
        recordDao.save(record);
        response.setContentType("text/html;charset=utf-8");
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/buy")
    public void buy(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String select = request.getParameter("select");
        String price = request.getParameter("price");
        String number = request.getParameter("number");
        int num = Integer.parseInt(number);
        String tele = request.getParameter("tele");
        String addr = request.getParameter("addr");
        String state = request.getParameter("recordState");
        int recordState = Integer.parseInt(state);
        //  System.out.print(select.toString()+";"+price.toString()+";"+number.toString()+";"+tele+";"+addr+";"+num);
        User user = (User) request.getSession().getAttribute("user");

        Record record = new Record();
        record.setUserId(user.getId());
        record.setItemId(Long.parseLong(request.getParameter("itemId")));
        record.setItemState(1);
        record.setFormNumber(System.currentTimeMillis());
        record.setFormState(recordState);
        record.setTele(tele);
        record.setAddr(addr);
        record.setSelType(select + "-" + price);
        record.setSelNumber(num);
        if (recordState == 1) {
            record.setStar(5);
            record.setComment("Default Rating from system");
            record.setCommentState(0);
        }
        recordDao.save(record);
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "displayCert")
    public String displayCert(HttpServletRequest request, Model model) {
        Long userId = ((User) request.getSession().getAttribute("user")).getId();
        List<Object[]> objects = recordDao.findByUserIdCert(userId);
        Object[] obj;
        ArrayList<Object> arrayList = new ArrayList<>();
        for (int i = 0; i < objects.size(); i++) {
            obj = objects.get(i);
            obj[4] = ((String) obj[4]).split("-");
            arrayList.add(obj);

        }

        model.addAttribute("arrayList", arrayList);

        return "displayCert";
    }

    @RequestMapping(value = "/changeToDone")
    public void changeToDone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pay = request.getParameter("pay");
        String[] records = request.getParameter("records").split("-");
        String tele = request.getParameter("tele");
        String addr = request.getParameter("addr");
        Long id;
        Record record;
        for (int i = 0; i < records.length; i++) {
            id = Long.parseLong(records[i]);
            record = recordDao.getById(id);
            record.setItemState(1);
            record.setDate(new Timestamp(System.currentTimeMillis()));
            record.setFormNumber(System.currentTimeMillis());
            if (pay.equals("1")) {
                record.setFormState(1);
                record.setStar(5);
                record.setComment("系统默认好评");
            }
            record.setTele(tele);
            record.setAddr(addr);
            recordDao.update(record);

        }
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/deleteR")
    public void deleteR(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] records = request.getParameter("records").split("-");
        Long id;
        for (int i = 0; i < records.length; i++) {
            id = Long.parseLong(records[i]);
            recordDao.delete(id);
        }
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/itemPaid")
    public String itemPaid(HttpServletRequest request, Model model) {
        Long userId = ((User) request.getSession().getAttribute("user")).getId();
        List<Object[]> objects = recordDao.findByUserIdPaid(userId);
        Object[] obj;
        ArrayList<Object> arrayList = new ArrayList<>();
        for (int i = 0; i < objects.size(); i++) {
            obj = objects.get(i);
            Long orderId = (Long) obj[2];
            Object orderInfo = recordDao.findRec(orderId);
            obj[2] = orderInfo;
            obj[5] = ((String) obj[5]).split("-");
            arrayList.add(obj);
        }

        // Long id = Long.parseLong(objects.get(2));
        // Object orderInfo = recordDao.findRec(id);
        // arrayList.add(orderInfo);

        model.addAttribute("arrayList", arrayList);
        return "itemPaid";
    }

    @RequestMapping(value = "/paidInfo")
    public String paidInfo(HttpServletRequest request, Model model) {
        return "paidInfo";
    }

    @RequestMapping(value = "/doneToPaid")
    public void doneToPaid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("record"));
        Record record = recordDao.getById(id);
        record.setFormState(1);
        record.setStar(5);
        record.setComment("系统默认好评");
        recordDao.update(record);
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/deleteDone")
    public void deleteDone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("record"));
        recordDao.delete(id);
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "/commDone")
    public void commDone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("record"));
        Record record = recordDao.getById(id);
        record.setCommentState(1);
        String count = request.getParameter("count");
        String comm = request.getParameter("comm");
        record.setStar(Integer.parseInt(count));
        record.setComment(comm);
        recordDao.update(record);
        response.getWriter().print("ok");
    }

    @RequestMapping(value = "lookingRecord")
    public String lookingRecord(HttpServletRequest request, Model model) {
        Long id = Long.parseLong(request.getParameter("id"));
        Object obj = recordDao.findRec(id);
        model.addAttribute("obj", obj);
        return "paidInfo";
    }

    @RequestMapping(value = "handOut")
    public String handOut(HttpServletRequest request, Model model) {
        Long id = ((User) request.getSession().getAttribute("user")).getId();
        List<Object[]> list = recordDao.findMyHandOut(id);
        Object[] obj;
        ArrayList<Object> arrayList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            obj = list.get(i);
            obj[5] = ((String) obj[5]).split("-");
            arrayList.add(obj);
        }
        model.addAttribute("arrayList", arrayList);
        return "handOut";
    }

    @RequestMapping(value = "handSure")
    public void handSure(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("record"));
        Record record = recordDao.getById(id);
        record.setFormState(2);
        recordDao.update(record);
        response.getWriter().print("ok");
    }
}
