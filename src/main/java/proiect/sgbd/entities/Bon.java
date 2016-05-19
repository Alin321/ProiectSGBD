package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the BON database table.
 * 
 */
@Entity
@NamedQuery(name="Bon.findAll", query="SELECT b FROM Bon b")
public class Bon implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_CREARE")
	private Date dataCreare;

	private BigDecimal pret;

	//bi-directional many-to-one association to Pizza
	@ManyToOne
	@JoinColumn(name="ID_PIZZA")
	private Pizza pizza;

	//bi-directional many-to-one association to Vanzari
	@OneToMany(mappedBy="bon")
	private List<Vanzari> vanzaris;

	public Bon() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDataCreare() {
		return this.dataCreare;
	}

	public void setDataCreare(Date dataCreare) {
		this.dataCreare = dataCreare;
	}

	public BigDecimal getPret() {
		return this.pret;
	}

	public void setPret(BigDecimal pret) {
		this.pret = pret;
	}

	public Pizza getPizza() {
		return this.pizza;
	}

	public void setPizza(Pizza pizza) {
		this.pizza = pizza;
	}

	public List<Vanzari> getVanzaris() {
		return this.vanzaris;
	}

	public void setVanzaris(List<Vanzari> vanzaris) {
		this.vanzaris = vanzaris;
	}

	public Vanzari addVanzari(Vanzari vanzari) {
		getVanzaris().add(vanzari);
		vanzari.setBon(this);

		return vanzari;
	}

	public Vanzari removeVanzari(Vanzari vanzari) {
		getVanzaris().remove(vanzari);
		vanzari.setBon(null);

		return vanzari;
	}

}