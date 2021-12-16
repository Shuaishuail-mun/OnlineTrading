package tian.base;

import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;

import javax.annotation.Resource;
import java.lang.reflect.ParameterizedType;
import java.util.List;

public class BaseDaoImpl<T> implements BaseDao<T> {
    @Resource
    private SessionFactory sessionFactory;
    private Class<T> clazz;

    public BaseDaoImpl() {
        ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();
        this.clazz = (Class<T>) pt.getActualTypeArguments()[0];

    }

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(T entity) {
        // TODO Auto-generated method stub
        getSession().save(entity);
    }

    @Override
    public void delete(Long id) {
        // TODO Auto-generated method stub
        Object obj = getById(id);
        if (obj != null) {
            getSession().delete(obj);
        }
    }

    @Override
    public void update(T entity) {
        // TODO Auto-generated method stub
        getSession().update(entity);
    }

    @Override
    public T getById(Long id) {
        // TODO Auto-generated method stub
        return (T) getSession().get(clazz, id);
    }

    @Override
    public List<T> getByIds(Long[] ids) {
        // TODO Auto-generated method stub
        return getSession().createQuery(
                "from " + clazz.getSimpleName() + "where id in (:ids)")
                .setParameterList("ids", ids).list();

    }

    @Override
    public List<T> findAll() {
        // TODO Auto-generated method stub
        return getSession().createQuery(
                "from " + clazz.getSimpleName())
                .list();
    }


}
