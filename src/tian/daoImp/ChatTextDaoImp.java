package tian.daoImp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tian.base.BaseDaoImpl;
import tian.dao.ChatTextDao;
import tian.table.ChatText;

import java.util.List;

@Service
@Transactional
public class ChatTextDaoImp extends BaseDaoImpl<ChatText> implements ChatTextDao {
    @Override
    public List<ChatText> findByRandS(Long sendId, Long receId) {
        return getSession().createQuery("from ChatText as chatText where chatText.sendId=? and chatText.receId=?")
                .setLong(0,sendId).setLong(1,receId).list();
    }

    @Override
    public List<Object[]> findByR(Long receId) {
        return  getSession().createQuery("select user.name,chatText.id  from User as user,ChatText as chatText where" +
                " user.id=chatText.sendId and chatText.receId=? and chatText.content!=?")
                .setLong(0,receId).setString(1,"")
                        .list();
    }
}
