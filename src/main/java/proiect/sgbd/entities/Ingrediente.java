package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the INGREDIENTE database table.
 * 
 */
@Entity
@NamedQuery(name="Ingrediente.findAll", query="SELECT i FROM Ingrediente i")
public class Ingrediente implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private String nume;

	@Column(name="PRET_FURNIZOR")
	private BigDecimal pretFurnizor;

	//bi-directional many-to-many association to Pizza
	@ManyToMany
	@JoinTable(
		name="INGREDIENTE_PIZZA"
		, joinColumns={
			@JoinColumn(name="ID_INGREDIENT")
			}
		, inverseJoinColumns={
			@JoinColumn(name="ID_PIZZA")
			}
		)
	private List<Pizza> pizzas;

	public Ingrediente() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNume() {
		return this.nume;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public BigDecimal getPretFurnizor() {
		return this.pretFurnizor;
	}

	public void setPretFurnizor(BigDecimal pretFurnizor) {
		this.pretFurnizor = pretFurnizor;
	}

	public List<Pizza> getPizzas() {
		return this.pizzas;
	}

	public void setPizzas(List<Pizza> pizzas) {
		this.pizzas = pizzas;
	}

}