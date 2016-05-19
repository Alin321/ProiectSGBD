package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the CARD database table.
 * 
 */
@Entity
@NamedQuery(name="Card.findAll", query="SELECT c FROM Card c")
public class Card implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_NASTERE")
	private Date dataNastere;

	private BigDecimal sold;

	//bi-directional many-to-one association to Client
	@ManyToOne
	@JoinColumn(name="ID_CLIENT")
	private Client client;

	public Card() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDataNastere() {
		return this.dataNastere;
	}

	public void setDataNastere(Date dataNastere) {
		this.dataNastere = dataNastere;
	}

	public BigDecimal getSold() {
		return this.sold;
	}

	public void setSold(BigDecimal sold) {
		this.sold = sold;
	}

	public Client getClient() {
		return this.client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

}