package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the PIZZA database table.
 * 
 */
@Entity
@NamedQuery(name="Pizza.findAll", query="SELECT p FROM Pizza p")
public class Pizza implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private String dimensiune;

	private String nume;

	private BigDecimal pret;

	private String tip;

	//bi-directional many-to-one association to Bon
	@OneToMany(mappedBy="pizza")
	private List<Bon> bons;

	//bi-directional many-to-many association to Ingrediente
	@ManyToMany(mappedBy="pizzas")
	private List<Ingrediente> ingredientes;

	public Pizza() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDimensiune() {
		return this.dimensiune;
	}

	public void setDimensiune(String dimensiune) {
		this.dimensiune = dimensiune;
	}

	public String getNume() {
		return this.nume;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public BigDecimal getPret() {
		return this.pret;
	}

	public void setPret(BigDecimal pret) {
		this.pret = pret;
	}

	public String getTip() {
		return this.tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public List<Bon> getBons() {
		return this.bons;
	}

	public void setBons(List<Bon> bons) {
		this.bons = bons;
	}

	public Bon addBon(Bon bon) {
		getBons().add(bon);
		bon.setPizza(this);

		return bon;
	}

	public Bon removeBon(Bon bon) {
		getBons().remove(bon);
		bon.setPizza(null);

		return bon;
	}

	public List<Ingrediente> getIngredientes() {
		return this.ingredientes;
	}

	public void setIngredientes(List<Ingrediente> ingredientes) {
		this.ingredientes = ingredientes;
	}

}