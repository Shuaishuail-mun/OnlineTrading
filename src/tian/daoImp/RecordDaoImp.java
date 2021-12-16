package tian.daoImp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tian.base.BaseDaoImpl;
import tian.dao.RecordDao;
import tian.table.Record;

import java.util.List;

@Service
@Transactional
public class RecordDaoImp extends BaseDaoImpl<Record> implements RecordDao {
    @Override
    public Object findStarAndCount(Long itemId) {
        return
                getSession().
                        createQuery("select count(*),round(avg(record.star),1) from Record as record where record.itemId=?  and record.formState!=0")
                .setLong(0,itemId).uniqueResult();
    }

    @Override
    public List<Object> findComment(Long itemId) {
        return getSession().createQuery("select user.name, record.star,record.comment from User as user,Record as record where " +
                "user.id=record.userId and record.itemId=? and record.formState!=0")
                .setLong(0,itemId).list();

    }

    @Override
    public List<Object[]> findByUserIdCert(Long userId) {
        return getSession().createQuery("select item.name,item.keyWord,record.id,record.itemId,record.selType,record.selNumber from Item as item,Record as record where " +
                "item.id=record.itemId and record.userId=? and record.itemState=0")
                .setLong(0,userId).list();

    }

    @Override
    public List<Object[]> findByUserIdPaid(Long userId) {
        return getSession().createQuery("select item.name,item.keyWord,record.id,record.itemId,record.formState,record.selType,record.selNumber,record.commentState from Item as item,Record as record where item.id=record.itemId and record.userId=? and record.itemState=1")
                .setLong(0,userId).list();
    }

    @Override
    public Object findRec(Long id) {
        return getSession().createQuery("select record.date,record.formNumber,record.tele,record.addr,record.id from Record as record where record.id=?").setLong(0,id).uniqueResult();
    }

    @Override
    public List<Object[]> findMyHandOut(Long userId) {
        return getSession().createQuery("select item.name,record.id,record.itemId,record.tele,record.addr,record.selType,record.selNumber,record.formNumber" +
                " from Item as item,Record as record where item.userId=? and item.id=record.itemId and record.formState=1")
                .setLong(0,userId).list();
    }

    @Override
    public List<Object> findByItemId(Long itemId) {
        return getSession().createQuery("select record.id from Record as record where record.itemId=?")
                .setLong(0,itemId).list();
    }
}
