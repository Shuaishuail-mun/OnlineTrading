package tian.dao;

import tian.base.BaseDao;
import tian.table.User;

import java.util.List;

public interface UserDao extends BaseDao<User> {
    List<User> findByName(String name);

}
