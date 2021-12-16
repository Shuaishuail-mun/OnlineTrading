package tian.dao;

import tian.base.BaseDao;
import tian.table.Item;

import java.math.BigInteger;
import java.util.List;

public interface ItemDao extends BaseDao<Item> {
    List<Object> findByUserId(Long userId);
   BigInteger findMaxId();
    List<Item> findRecentNew();
    List<Object[]> findByType(Long typeId);
    List<Object[]> findByKey(String key);

}
