package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the CLIENT database table.
 * 
 */
@Entity
@NamedQuery(name="Client.findAll", query="SELECT c FROM Client c")
public class Client implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	private String email;

	private String nume;

	private String parola;

	private String prenume;

	private String telefon;

	//bi-directional many-to-one association to Adresa
	@OneToMany(mappedBy="client")
	private List<Adresa> adresas;

	//bi-directional many-to-one association to Card
	@OneToMany(mappedBy="client")
	private List<Card> cards;

	//bi-directional many-to-one association to Vanzari
	@OneToMany(mappedBy="client")
	private List<Vanzari> vanzaris;

	public Client() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNume() {
		return this.nume;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public String getParola() {
		return this.parola;
	}

	public void setParola(String parola) {
		this.parola = parola;
	}

	public String getPrenume() {
		return this.prenume;
	}

	public void setPrenume(String prenume) {
		this.prenume = prenume;
	}

	public String getTelefon() {
		return this.telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}

	public List<Adresa> getAdresas() {
		return this.adresas;
	}

	public void setAdresas(List<Adresa> adresas) {
		this.adresas = adresas;
	}

	public Adresa addAdresa(Adresa adresa) {
		getAdresas().add(adresa);
		adresa.setClient(this);

		return adresa;
	}

	public Adresa removeAdresa(Adresa adresa) {
		getAdresas().remove(adresa);
		adresa.setClient(null);

		return adresa;
	}

	public List<Card> getCards() {
		return this.cards;
	}

	public void setCards(List<Card> cards) {
		this.cards = cards;
	}

	public Card addCard(Card card) {
		getCards().add(card);
		card.setClient(this);

		return card;
	}

	public Card removeCard(Card card) {
		getCards().remove(card);
		card.setClient(null);

		return card;
	}

	public List<Vanzari> getVanzaris() {
		return this.vanzaris;
	}

	public void setVanzaris(List<Vanzari> vanzaris) {
		this.vanzaris = vanzaris;
	}

	public Vanzari addVanzari(Vanzari vanzari) {
		getVanzaris().add(vanzari);
		vanzari.setClient(this);

		return vanzari;
	}

	public Vanzari removeVanzari(Vanzari vanzari) {
		getVanzaris().remove(vanzari);
		vanzari.setClient(null);

		return vanzari;
	}

}