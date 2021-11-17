package com.example.ug_javamidterm;

import javax.persistence.*;

@Entity
@Table(name = "PRODUCTS")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private long id;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "BARCODE")
    private String barcode;

    @Column(name = "PRICE")
    private Float price;

    @Column(name = "AMOUNT")
    private int amount;

    public Product() {
    }

    public Product(long id, String title, String barcode, Float price, int amount) {
        this.id = id;
        this.title = title;
        this.barcode = barcode;
        this.price = price;
        this.amount = amount;
    }

    public Product(String title, String barcode, Float price, int amount) {
        this.title = title;
        this.barcode = barcode;
        this.price = price;
        this.amount = amount;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String description) {
        this.barcode = description;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float type) {
        this.price = type;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int salary) {
        this.amount = salary;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", barcode='" + barcode + '\'' +
                ", price=" + price +
                ", amount=" + amount +
                '}';
    }
}
