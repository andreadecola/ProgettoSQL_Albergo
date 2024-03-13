DROP TABLE IF EXISTS Albergo;
DROP TABLE IF EXISTS Camera;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Prenotazione;
DROP TABLE IF EXISTS Dipendente;
DROP TABLE IF EXISTS Facility;

CREATE TABLE Albergo(
albergoID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(150) NOT NULL,
indirizzo VARCHAR(150) UNIQUE NOT NULL ,
valutazione TINYINT NOT NULL CHECK (valutazione > 0  AND valutazione < 6 )
);

CREATE TABLE Camera(
cameraID INT PRIMARY KEY IDENTITY(1,1),
numero INT NOT NULL,
tipo VARCHAR(150) NOT NULL,
capacità INT NOT NULL,
tariffa DECIMAL(10,2),
albergoRIF INT NOT NULL,
FOREIGN KEY(albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
UNIQUE(albergoRIF , numero)
);

CREATE TABLE Cliente(
clienteID INT PRIMARY KEY IDENTITY (1,1),
nome VARCHAR(150) NOT NULL,
cognome VARCHAR(150) NOT NULL,
contatto VARCHAR(150) NOT NULL
);

CREATE TABLE Prenotazione(
prenotazioneID INT PRIMARY KEY IDENTITY(1,1),
check_in DATE NOT NULL,
check_out DATE NOT NULL,
clienteRIF INT NOT NULL,
cameraRIF INT NOT NULL,
FOREIGN KEY (clienteRIF) REFERENCES Cliente(clienteID) ON DELETE CASCADE,
FOREIGN KEY (cameraRIF) REFERENCES Camera(cameraID) ON DELETE CASCADE,
UNIQUE(check_in,check_out,cameraRIF)
);


CREATE TABLE Dipendente(
dipendenteID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(150) NOT NULL,
cognome VARCHAR(150) NOT NULL,
contatto VARCHAR(150) NOT NULL,
posizione_lavorativa VARCHAR (150) NOT NULL,
codFis CHAR(16) NOT NULL UNIQUE,
albergoRIF INT NOT NULL,
FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
UNIQUE(dipendenteID,albergoRIF)
);

CREATE TABLE Facility(
facilityID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(150) NOT NULL,
tipo VARCHAR(150) NOT NULL,
orario TIME NOT NULL,
albergoRIF INT NOT NULL,
FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE
);

INSERT INTO Albergo(nome,indirizzo,valutazione) VALUES

('Hotel Roma',	'Via del Corso, 123',	4),
('Grand Hotel',	'Piazza di Spagna, 10',5),
('Bella Vista',	'Lungotevere, 55',3),
('Albergo Italia',	'Via Veneto, 78,',4),
('Hotel Splendido',	'Viale Trastevere, 200',5)

INSERT INTO Camera(numero,tipo,capacità,tariffa,albergoRIF) VALUES
(101,'Singola',	1,80.00,2),
(201,'Doppia',2,120.00,1),
(301,'	Suite',	3,200.00,3),	
(102,'Singola',	1,85.00,4),	
(202,'Doppia',	2,130.00,2)

INSERT INTO Cliente (nome, cognome, contatto)
VALUES
('Marco', 'Rossi', 'marco.rossi@email.com'),
('Laura', 'Bianchi', 'laura.bianchi@email.com'),
('Luca', 'Verdi', 'luca.verdi@email.com'),
('Anna', 'Esposito', 'anna.esposito@email.com'),
('Giuseppe', 'Russo', 'giuseppe.russo@email.com');


INSERT INTO Prenotazione (check_in, check_out, clienteRIF, cameraRIF)
VALUES
('2024-03-20', '2024-03-25', 1, 2),
('2024-04-10', '2024-04-15', 3, 4),
('2024-05-05', '2024-05-10', 2, 1),
('2024-06-15', '2024-06-20', 4, 3),
('2024-07-01', '2024-07-05', 5, 5);

INSERT INTO Dipendente (nome, cognome, contatto, posizione_lavorativa, codFis, albergoRIF)
VALUES
('Mario', 'Rossi', 'mario.rossi@email.com', 'Receptionist', 'MR12345678901234', 1),
('Laura', 'Bianchi', 'laura.bianchi@email.com', 'Chef', 'LB98765432109876', 2),
('Luca', 'Verdi', 'luca.verdi@email.com', 'Barista', 'LV56789012345678', 3),
('Anna', 'Esposito', 'anna.esposito@email.com', 'Housekeeping', 'AE34567890123456', 1),
('Giuseppe', 'Russo', 'giuseppe.russo@email.com', 'Manager', 'GR01234567890123', 2);

INSERT INTO Facility (nome, tipo, orario, albergoRIF)
VALUES
    ('Piscina', 'Sport', '10:00', 1),
    ('Ristorante', 'Cibo', '19:30', 2),
    ('Palestra', 'Sport', '08:00', 3),
    ('Spa', 'Benessere', '15:00', 1),
    ('Sala Conferenze', 'Business', '14:00', 2);
