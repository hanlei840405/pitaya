package com.fruit.pitaya.service;

import com.fruit.pitaya.mapper.CartDetailMapper;
import com.fruit.pitaya.mapper.CartDetailVOMapper;
import com.fruit.pitaya.mapper.CartMapper;
import com.fruit.pitaya.model.Cart;
import com.fruit.pitaya.model.CartDetail;
import com.fruit.pitaya.model.CartDetailVO;
import com.fruit.pitaya.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

/**
 * Created by hanlei6 on 2016/10/26.
 */
@Service
public class CartService {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private CustomerService customerService;

    public Cart get(String cusCode) {
        List<Cart> carts = jdbcTemplate.query("SELECT * FROM mall_cart WHERE cusCode=?", ps -> {
            ps.setString(1, cusCode);
        }, new CartMapper());
        if (carts.isEmpty()) {
            return null;
        }
        Cart cart = carts.get(0);
        cart.setCartDetailVOs(findByCusCode(cusCode));
        return cart;
    }

    public List<CartDetailVO> findByCusCode(String cusCode) {
        return jdbcTemplate.query("SELECT t1.*,t2.skuName,t2.specName,t2.image FROM mall_cart_de t1 INNER JOIN mall_sku t2 ON t1.sku = t2.sku WHERE cusCode=?", ps -> {
            ps.setString(1, cusCode);
        }, new CartDetailVOMapper());
    }

    public CartDetail get(String cusCode, String sku) {
        List<CartDetail> cartDetails = jdbcTemplate.query("SELECT * FROM mall_cart_de WHERE cusCode=? AND sku=?", ps -> {
            ps.setString(1, cusCode);
            ps.setString(2, sku);
        }, new CartDetailMapper());
        if (cartDetails.isEmpty()) {
            return null;
        }
        return cartDetails.get(0);
    }

    @Transactional
    public void createCart(Cart cart, CartDetail cartDetail) {
        jdbcTemplate.update("INSERT INTO mall_cart (cusCode, totalCount, amount) VALUES (?,?,?)",
                ps -> {
                    ps.setString(1, cart.getCusCode());
                    ps.setInt(2, cart.getTotalCount());
                    ps.setBigDecimal(3, cart.getAmount());
                });
        addSku(cartDetail);
    }

    @Transactional
    public void updateCart(Cart cart) {
        jdbcTemplate.update("UPDATE mall_cart SET totalCount=?, amount=? WHERE cusCode=?",
                ps -> {
                    ps.setInt(1, cart.getTotalCount());
                    ps.setBigDecimal(2, cart.getAmount());
                    ps.setString(3, cart.getCusCode());
                });
    }

    @Transactional
    public void addSku(CartDetail cartDetail) {
        jdbcTemplate.update("INSERT INTO mall_cart_de (cusCode, sku, priceType, skuCount, price, skuAmount) VALUES (?,?,?,?,?,?)",
                ps -> {
                    ps.setString(1, cartDetail.getCusCode());
                    ps.setString(2, cartDetail.getSku());
                    ps.setString(3, cartDetail.getPriceType());
                    ps.setInt(4, cartDetail.getSkuCount());
                    ps.setBigDecimal(5, cartDetail.getPrice());
                    ps.setBigDecimal(6, cartDetail.getSkuAmount());
                });
    }

    @Transactional
    public void clearCart(String cusCode) {
        jdbcTemplate.update("DELETE FROM mall_cart WHERE cusCode=?", ps -> {
            ps.setString(1, cusCode);
        });
        clearCartDetail(cusCode);
    }

    @Transactional
    public void clearCartDetail(String cusCode, String... skus) {
        if (skus != null) {
            NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(jdbcTemplate);

            MapSqlParameterSource parameters = new MapSqlParameterSource();
            parameters.addValue("cusCode", cusCode);
            String sql;
            if (skus.length == 0) {
                sql = "DELETE FROM mall_cart_de WHERE cusCode=:cusCode";
            } else {
                parameters.addValue("skus", Arrays.asList(skus));
                sql = "DELETE FROM mall_cart_de WHERE cusCode=:cusCode AND sku in (:skus)";
            }
            namedParameterJdbcTemplate.update(sql, parameters);
        }
    }

    @Transactional
    public void process(String cusCode, String sku, String priceType, BigDecimal price, int count) throws Exception {
        // 判断购物车是否有商品
        CartDetail cartDetail = get(cusCode, sku);
        if (cartDetail != null) {
            count += cartDetail.getSkuCount();
            clearCartDetail(cusCode, sku);
        } else {
            cartDetail = new CartDetail();
            cartDetail.setCusCode(cusCode);
            cartDetail.setSku(sku);
        }
        cartDetail.setSkuCount(count);
        cartDetail.setPriceType(priceType);
        cartDetail.setPrice(price);
        cartDetail.setSkuAmount(price.multiply(new BigDecimal(count)));

        Cart cart = get(cusCode);
        if (cart == null) {
            cart = new Cart();
            cart.setTotalCount(count);
            cart.setAmount(cartDetail.getSkuAmount());
            cart.setCusCode(cusCode);
            createCart(cart, cartDetail);
        } else {
            cart.setTotalCount(cart.getTotalCount() + count);
            cart.setAmount(cart.getAmount().add(cartDetail.getSkuAmount()));
            updateCart(cart);
            addSku(cartDetail);
        }
        Customer customer = customerService.get(cusCode);
        customer.setCoupon(0);
        customerService.update(customer);
    }
}
