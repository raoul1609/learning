import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'

function App() {
  
  return (
  <>
    <div className="intro">
      <h1>Bienvenue sur mon site !</h1>
    </div>
    <p className="summary">
      Vous trouverez mes réflexions ici.
      <br></br>
      <b>Et des <i>photos</i></b> de scientifiques!</p>
  </>
  );
}

export default App

export function MyComponent () {
  return (
    <>
      <h1>Test creation de composant React a partir d&apos;un autre composant</h1>
      <App/>
      <App/>
    </>
  );
}

export function Exo1() {
  const source = "https://i.imgur.com/7vQD0fPs.jpg"
  const nom = "Gregorio Y. Zara"
  return (
    <>
    <p> ### DEFI 1/4 ### </p>
    <img
      className="avatar"
      src="https://i.imgur.com/lICfvbD.jpg"
      alt="Aklilu Lemma"
    />

    <img
      className="avatar"
      src= {source}
      alt= {nom}
    />

    </>
  );
}

const person = {
  name: 'Gregorio Y. Zara',
  theme: {
    backgroundColor: 'black',
    color:'pink'
  }
};

// tst sur interpollation, passer les donnees dans les {}
export function TodoList() {
  return (
    <div style={person.theme}>
      <h1>Liste des taches de {person.name}</h1>
      <img
        className="avatar"
        src="https://i.imgur.com/7vQD0fPs.jpg"
        alt="Gregorio Y. Zara"
      />
      <ul>
        <li>Ameliorer le visiophone</li>
        <li>Preparer les cours d&apos;aeronautiques</li>
        <li>Travailler sur un moteur a alcool</li>
      </ul>
    </div>
  )
};

// test sur les props, defis a la fin de la lecture de cette partie 

import { getImageUrl } from './utils.js';

export function Profile({id_image,name_autor, professions,recompenses, decouvertes }) {
  <>
    <h1>Scientifiques remarquables</h1>
      <section className="profile">
        <h2>{name_autor}</h2>
        <img
          className="avatar"
          src={getImageUrl(id_image)}
          alt={name_autor}
          width={70}
          height={70}
        />
        <ul>
          <li>
            <b>Profession : </b>
            {professions}
          </li>
          <li>
            <b>Récompenses : 4 </b>
              {recompenses}
          </li>
          <li>
            <b>A découvert : </b>
            {decouvertes}
          </li>
        </ul>
      </section>
  </>
}

export  function TestProps() {
  return (
    <>
      <Profile
        id_image={'szV5sdG'}
        name_autor={"Maria Skłodowska-Curie"}
        professions={"physicienne et chimiste"}
        recompenses={"(Prix Nobel de Physique, Prix Nobel de Chimie, Médaille Davy, Médaille Matteucci)"}
        decouvertes={"le Polonium (élément chimique)"}
      />
      <Profile
        id_image={'YfeOqp2'}
        name_autor={"Katsuko Saruhashi"}
        professions={"géochimiste"}
        recompenses={"(Prix Miyake de géochimie, Prix Tanaka)"}
        decouvertes={"une méthode de mesure du dioxyde de carbone dans l’eau de mer"}
      />
    </>
  );
}
