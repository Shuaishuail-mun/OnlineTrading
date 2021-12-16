package tian.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import tian.dao.ChatTextDao;
import tian.table.ChatText;
import tian.table.User;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

@Controller
@Scope("prototype")
@Transactional
public class Chat {
    @Resource
    private ChatTextDao chatTextDao;

    @RequestMapping(value = "/sendText")
    public void sendText(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String content = request.getParameter("text");
        Long receId = Long.parseLong(request.getParameter("he"));
        Long sendId = ((User) request.getSession().getAttribute("user")).getId();
        List<ChatText> chatTexts = chatTextDao.findByRandS(sendId, receId);
        if (chatTexts.size() < 1) {
            ChatText chatText = new ChatText();
            chatText.setSendId(sendId);
            chatText.setReceId(receId);
            chatText.setContent(content + "-");
            chatTextDao.save(chatText);
        } else {
            ChatText c = chatTexts.get(0);
            ChatText temp = chatTextDao.getById(c.getId());
            String s = c.getContent() + content + "-";
            temp.setContent(s);
            chatTextDao.update(temp);
        }
        response.getWriter().print("0");

    }

    @RequestMapping(value = "/degFeed")
    public void degFeed(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        PrintWriter writer = response.getWriter();
        Long sendId = Long.parseLong(request.getParameter("he"));
        Long receId = ((User) request.getSession().getAttribute("user")).getId();
        List<ChatText> chatTexts = chatTextDao.findByRandS(sendId, receId);
        if (chatTexts.size() < 1) {
            writer.print("0");

        } else if (chatTexts.get(0).getContent().equals("")) {
            writer.print("0");

        } else {
            ChatText c = chatTexts.get(0);
            writer.print(c.getContent());
            ChatText cc = chatTextDao.getById(c.getId());
            cc.setContent("");
            chatTextDao.update(cc);


        }
    }

    @RequestMapping(value = "/sellerChat")
    public String sellerChat(HttpServletRequest request, Model model) {
        Long receId = ((User) request.getSession().getAttribute("user")).getId();
        List<Object[]> objects = chatTextDao.findByR(receId);
        List<Integer> numbers = new ArrayList<Integer>();
        for (int i = 0; i < objects.size(); i++) {
            Object[] item = objects.get(i);
            Long id = (Long) item[1];
            ChatText chatText = chatTextDao.getById(id);
            String[] content = chatText.getContent().split("-");
            numbers.add(content.length);
        }
        model.addAttribute("objects", objects);
        model.addAttribute("numbers", numbers);
        return "sellerChat";
    }

    @RequestMapping(value = "/selRece")
    public void selRece(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        ChatText chatText = chatTextDao.getById(id);
        response.setContentType("text/text;charset=utf-8");
        PrintWriter writer = response.getWriter();
        if (chatText.getContent().equals("")) {
            writer.print("0");
        } else {
            String s = chatText.getContent();

            chatText.setContent("");
            chatTextDao.update(chatText);
            writer.print(s);
        }
    }

    @RequestMapping(value = "/selSend")
    public void selSend(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String content = request.getParameter("content");
        Long id = Long.parseLong(request.getParameter("id"));
        ChatText ct = chatTextDao.getById(id);
        Long receId = ct.getSendId();
        Long sendId = ct.getReceId();
        List<ChatText> chatTexts = chatTextDao.findByRandS(sendId, receId);
        if (chatTexts.size() < 1) {
            ChatText chatText = new ChatText();
            chatText.setSendId(sendId);
            chatText.setReceId(receId);
            chatText.setContent(content + "-");
            chatTextDao.save(chatText);
        } else {

            ChatText c = chatTexts.get(0);
            String s = c.getContent() + content + "-";
            ChatText temp = chatTextDao.getById(c.getId());
            temp.setContent(s);

            chatTextDao.update(temp);
        }
        response.getWriter().print("0");

    }
}
