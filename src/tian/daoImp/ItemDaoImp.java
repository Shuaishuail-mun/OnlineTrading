package tian.daoImp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tian.base.BaseDaoImpl;
import tian.dao.ItemDao;
import tian.table.Item;

import java.math.BigInteger;
import java.util.List;

@Service
@Transactional
public class ItemDaoImp extends BaseDaoImpl<Item> implements ItemDao {
    @Override
    public List<Object> findByUserId(Long userId) {
      //  return  getSession().createQuery("select p.id,p.title,p.date from WorkLog as p where p.userId=?")
      //          .setLong(0,userId).list();
        return getSession().createQuery("select item.id,item.name,item.price from Item as item where item.userId=?")
                .setLong(0,userId).list();
    }

    @Override
    public BigInteger findMaxId() {

        return (BigInteger)getSession().createSQLQuery("Select AUTO_INCREMENT from INFORMATION_SCHEMA.TABLES  Where table_schema = 'tianlv' \n" +
                " \n" +
                "AND table_name LIKE 'tian_item'").uniqueResult();


    }

    @Override
    public List<Item> findRecentNew() {
        return getSession().createQuery("from Item as item order by id desc")
                .setFirstResult(0).
                        setMaxResults(30).list();
    }

    @Override
    public List<Object[]> findByType(Long typeId) {
        return getSession().createQuery("select item.id,item.name,item.keyWord,item.price from Item as item where " +
                " item.typeId=?")
                .setLong(0,typeId).list();
    }

    @Override
    public List<Object[]> findByKey(String key) {
        return  getSession().createQuery("select item.id,item.name,item.keyWord,item.price from Item as item where " +
                " item.keyWord like ? or item.name like ?")
                .setString(0,"%"+key+"%").setString(1,"%"+key +"%").list();
    }

}
