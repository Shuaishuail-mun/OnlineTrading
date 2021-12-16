package tian.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import tian.dao.ItemDao;
import tian.dao.RecordDao;
import tian.dao.TypeDao;
import tian.table.Item;
import tian.table.Type;
import tian.table.User;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@Scope("prototype")
@Transactional
public class Mine {
    @Resource
    private TypeDao typeDao;
    @Resource
    private ItemDao itemDao;
    @Resource
    private RecordDao recordDao;

    @RequestMapping(value = "/addTypePage")
    public String addTypePage() {
        return "addType";
    }

    @RequestMapping(value = "/addType")
    public String addType(@RequestParam("typeImg") MultipartFile file, HttpServletRequest request, Model model) throws Exception {
        String fileName = file.getOriginalFilename();
        String path = request.getServletContext().getRealPath("/upload") + "/" + fileName;
        file.transferTo(new File(path));
        String typeName = request.getParameter("typeName");
        String src = "/upload/" + fileName;
        Type type = new Type();
        type.setName(typeName);
        type.setImgAdr(src);
        typeDao.save(type);
        model.addAttribute("src", src);
        return "addType";

    }

    @RequestMapping(value = "/myIndex")
    public String myIndex(Model model) {
        List<Type> types = typeDao.findAll();
        List<Item> items = itemDao.findRecentNew();
        model.addAttribute("items", items);
        model.addAttribute("types", types);
        Item item;
        Object[] com;
        for (int i = 0; i < items.size(); i++) {
            item = items.get(i);
            com = (Object[]) recordDao.findStarAndCount(item.getId());
            item.setStar(com[1] + "");
            item.setSales(com[0] + "");
        }
        return "myIndex";
    }

    @RequestMapping(value = "/sell")
    public String sell(HttpServletRequest request, Model model) {
        List<Type> types = typeDao.findAll();
        model.addAttribute("types", types);
        return "sell";
    }

    @RequestMapping(value = "/addItems")
    public String addItems(@RequestParam("image") MultipartFile files[], HttpServletRequest request, Model model) throws Exception {
        String name = request.getParameter("name");
        String keyWord = request.getParameter("keyWord");
        String price = request.getParameter("price");
        String select = request.getParameter("select");
        String description = request.getParameter("description");
        Long typeId = Long.parseLong(request.getParameter("typeSelect"));
        int imageNum = 0;
        String temp = "";
        Long userId = ((User) request.getSession().getAttribute("user")).getId();
        BigInteger id = itemDao.findMaxId();

        System.out.print(id + "0000");
        for (int i = 0; i < files.length; i++) {
            temp = files[i].getOriginalFilename();
            if (!temp.equals("")) {
                imageNum++;
                files[i].transferTo(new File(request.getServletContext().getRealPath("/upload") + "/" + id + "" + imageNum + ".png"));
            }


        }

        Item item = new Item();
        item.setName(name);
        item.setKeyWord(keyWord);
        item.setPrice(price);
        item.setSel(select);
        item.setDescription(description);

        item.setImageNum(imageNum);
        item.setTypeId(typeId);
        item.setUserId(userId);
        itemDao.save(item);

        model.addAttribute("success", "true");
        List<Type> types = typeDao.findAll();
        model.addAttribute("types", types);
        return "sell";
    }

    @RequestMapping(value = "/mySell")
    public String mySell(HttpServletRequest request, Model model) {
        Long userId = ((User) request.getSession().getAttribute("user")).getId();
        List<Object> items = itemDao.findByUserId(userId);
        String ok = request.getParameter("ok");
        if (ok.equals("ok")) {
            model.addAttribute("ok", true);
        }
        model.addAttribute("items", items);
        return "mySell";
    }

    @RequestMapping(value = "/sellItem")
    public String sellItem(HttpServletRequest request, Model model) {
        Long id = Long.parseLong(request.getParameter("id"));
        Item item = itemDao.getById(id);
        Long typeId = item.getTypeId();
        model.addAttribute("item", item);
        List<Type> types = typeDao.findAll();
        model.addAttribute("types", types);
        model.addAttribute("typeId", typeId);
        Type type = typeDao.getById(typeId);
        model.addAttribute("sType", type);
        String sel = item.getSel();

        String[] strings = sel.split("\\|");
        ArrayList<String[]> arrayList = new ArrayList<String[]>();
        for (int i = 0; i < strings.length; i++) {

            arrayList.add(strings[i].split("-"));

        }
        String ok = request.getParameter("ok");
        if (ok.equals("ok")) {
            model.addAttribute("ok", true);
        }
        model.addAttribute("arrayList", arrayList);
        Object com = recordDao.findStarAndCount(id);
        model.addAttribute("com", com);
        return "sellItem";

    }

    @RequestMapping(value = "/editItems")
    public String editItems(@RequestParam("image") MultipartFile files[], HttpServletRequest request, Model model) throws IOException {
        String name = request.getParameter("name");
        String keyWord = request.getParameter("keyWord");
        String price = request.getParameter("price");
        String select = request.getParameter("select");
        String description = request.getParameter("description");
        Long typeId = Long.parseLong(request.getParameter("typeSelect"));
        int imageNum = 0;
        String temp = "";
        Long userId = ((User) request.getSession().getAttribute("user")).getId();
        Long id = Long.parseLong(request.getParameter("id"));
        Item item = itemDao.getById(id);
        int tempImgNum = item.getImageNum();
        for (int i = 1; i <= tempImgNum; i++) {
            new File(request.getServletContext().getRealPath("/upload") + "/" + id + "" + i + ".png").delete();
        }
        for (int i = 0; i < files.length; i++) {

            temp = files[i].getOriginalFilename();
            if (!temp.equals("")) {
                imageNum++;
                files[i].transferTo(new File(request.getServletContext().getRealPath("/upload") + "/" + id + "" + imageNum + ".png"));
            }
        }

        item.setName(name);
        item.setKeyWord(keyWord);
        item.setPrice(price);
        item.setSel(select);
        item.setDescription(description);
        item.setImageNum(imageNum);
        item.setTypeId(typeId);
        item.setUserId(userId);
        itemDao.update(item);

        return "redirect:sellItem?id=" + id + "&ok=ok";


    }

    @RequestMapping(value = "/deleteItem")
    public String deleteItem(HttpServletRequest request) {
        Long id = Long.parseLong(request.getParameter("id"));
        List<Object> objects = recordDao.findByItemId(id);
        for (int i = 0; i < objects.size(); i++) {
            recordDao.delete((Long)(objects.get(i)));
        }
        Item item = itemDao.getById(id);
        int imgNum = item.getImageNum();
        for (int i = 1; i <= imgNum; i++) {
            new File(request.getServletContext().getRealPath("/upload") + "/" + id + "" + i + ".png").delete();
        }
        itemDao.delete(id);
        return "redirect:mySell?ok=ok";
    }

    @RequestMapping(value = "/displayItem")
    public String displayItem(HttpServletRequest request, Model model) {
        Long id = Long.parseLong(request.getParameter("id"));
        Item item = itemDao.getById(id);
        model.addAttribute("item", item);
        String sel = item.getSel();

        String[] strings = sel.split("\\|");
        ArrayList<String[]> arrayList = new ArrayList<String[]>();
        for (int i = 0; i < strings.length; i++) {

            arrayList.add(strings[i].split("-"));

        }

        model.addAttribute("arrayList", arrayList);
        Object com = recordDao.findStarAndCount(id);
        model.addAttribute("com", com);
        List<Object> comm = recordDao.findComment(id);
        model.addAttribute("comm", comm);
        return "displayItem";
    }

    @RequestMapping(value = "typeItems")
    public String typeItems(HttpServletRequest request, Model model) {
        Long typeId = Long.parseLong(request.getParameter("id"));
        List<Object[]> objects = itemDao.findByType(typeId);
        ArrayList<Object[]> arrayList = new ArrayList<>();
        Object[] obj;
        for (int i = 0; i < objects.size(); i++) {
            obj = objects.get(i);
            Object[] obj1 = new Object[5];
            for (int j = 0; j < 4; j++) {
                obj1[j] = obj[j];
            }
            obj1[4] = recordDao.findStarAndCount((Long) obj[0]);
            arrayList.add(obj1);
        }
        model.addAttribute("arrayList", arrayList);

        return "typeItems";
    }

    @RequestMapping(value = "/search")
    public String search(HttpServletRequest request, Model model) {
        String key = request.getParameter("search");
        List<Object[]> objects = itemDao.findByKey(key);
        ArrayList<Object[]> arrayList = new ArrayList<>();
        Object[] obj;
        for (int i = 0; i < objects.size(); i++) {
            obj = objects.get(i);
            Object[] obj1 = new Object[5];
            for (int j = 0; j < 4; j++) {
                obj1[j] = obj[j];
            }
            obj1[4] = recordDao.findStarAndCount((Long) obj[0]);
            arrayList.add(obj1);
        }
        model.addAttribute("arrayList", arrayList);

        return "typeItems";
    }

    @RequestMapping(value = "/delTypePage")
    public String delTypePage(Model model) {
        List<Type> types=typeDao.findAll();
        model.addAttribute("types",types);
        return "delTypePage";
    }
    @RequestMapping(value = "/delType")
    public void delType(HttpServletRequest request,HttpServletResponse response)throws IOException{
        Long id=Long.parseLong(request.getParameter("id"));
        String imgAdr=typeDao.getById(id).getImgAdr();
        new File(request.getServletContext().getRealPath("")+imgAdr).delete();
        typeDao.delete(id);
        response.getWriter().print("ok");
    }
}
