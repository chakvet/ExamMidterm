import com.example.ug_javamidterm.Product;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

import javax.persistence.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class SimpleTest {

    @Test
    void test_db_writing() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Product product = new Product();
            product.setTitle("Test Product");
            product.setBarcode("9874374673");
            product.setPrice(399.99f);
            product.setAmount(200);

            entityManager.persist(product);

            entityTransaction.commit();

            TypedQuery<Product> test_query = entityManager.createQuery(
                    "SELECT v FROM Product v WHERE v.title = :title", Product.class
            );
            Product result = test_query.setParameter("title", "Test Product")
                    .getSingleResult();

            assertNotNull(result);

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }
    }

    @Test
    void test_db_update() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            TypedQuery<Product> test_query = entityManager.createQuery(
                    "SELECT v FROM Product v WHERE v.title = :title", Product.class
            );
            Product result = test_query.setParameter("title", "Test Product")
                    .setMaxResults(1)
                    .getSingleResult();

            result.setAmount(350);

            entityManager.persist(result);

            entityTransaction.commit();

            entityTransaction.begin();

            TypedQuery<Product> test_query_afterupd = entityManager.createQuery(
                    "SELECT v FROM Product v WHERE v.title = :title", Product.class
            );
            Product result_afterupd = test_query_afterupd.setParameter("title", "Test Product")
                    .setMaxResults(1)
                    .getSingleResult();

            assertEquals(350, result_afterupd.getAmount());

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }
    }

    @AfterAll
    static void clean_db() {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Query delete_query = entityManager.createQuery(
                    "DELETE FROM Product v WHERE v.title = :title");

            delete_query.setParameter("title", "Test Product").executeUpdate();

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }

    }
}
