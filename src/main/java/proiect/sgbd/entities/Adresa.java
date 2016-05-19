package proiect.sgbd.entities;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;


/**
 * The persistent class for the ADRESA database table.
 * 
 */
@Entity
@NamedQuery(name="Adresa.findAll", query="SELECT a FROM Adresa a")
public class Adresa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private BigDecimal apartament;

	private String bloc;

	private BigDecimal etaj;

	private BigDecimal numar;

	private String scara;

	private String strada;

	//bi-directional many-to-one association to Client
	@ManyToOne
	@JoinColumn(name="ID_CLIENT")
	private Client client;

	public Adresa() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getApartament() {
		return this.apartament;
	}

	public void setApartament(BigDecimal apartament) {
		this.apartament = apartament;
	}

	public String getBloc() {
		return this.bloc;
	}

	public void setBloc(String bloc) {
		this.bloc = bloc;
	}

	public BigDecimal getEtaj() {
		return this.etaj;
	}

	public void setEtaj(BigDecimal etaj) {
		this.etaj = etaj;
	}

	public BigDecimal getNumar() {
		return this.numar;
	}

	public void setNumar(BigDecimal numar) {
		this.numar = numar;
	}

	public String getScara() {
		return this.scara;
	}

	public void setScara(String scara) {
		this.scara = scara;
	}

	public String getStrada() {
		return this.strada;
	}

	public void setStrada(String strada) {
		this.strada = strada;
	}

	public Client getClient() {
		return this.client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

}