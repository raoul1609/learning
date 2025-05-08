import { getImageUrl } from './utils.js';

function Profile ({classe, img_src, img_alt, img_w = 70, img_h = 70}) {
  return (
    <>
      <img
        className="avatar"
        src={getImageUrl('szV5sdG')}
        alt="Maria Skłodowska-Curie"
        width={70}
        height={70}
      />
    </>
  )
};

export default function Gallery() {
  return (
    <div>
      <h1>Scientifiques remarquables</h1>
      <section className="profile">
        <h2>Maria Skłodowska-Curie</h2>
        <Profile 
          classe={"avatar"}
          img_alt={"Maria Skłodowska-Curie"}
          img_src={getImageUrl('szV5sdG')}
          img_h={70}
          img_w={70}
        />
        <ul>
          <li>
            <b>Profession: </b>
            physicienne et chimiste
          </li>
          <li>
            <b>Récompenses: 4 </b>
            (Prix Nobel de Physique, Prix Nobel de Chimie, Médaille Davy, Médaille Matteucci)
          </li>
          <li>
            <b>A découvert: </b>
            le Polonium (élément chimique)
          </li>
        </ul>
      </section>
      <section className="profile">
        <h2>Katsuko Saruhashi</h2>
        
        <Profile 
          classe={"avatar"}
          img_alt={"Katsuko Saruhashi"}
          img_src={getImageUrl('YfeOqp2')}
          img_h={70}
          img_w={70}
        />
        <ul>
          <li>
            <b>Profession: </b>
            géochimiste
          </li>
          <li>
            <b>Récompenses: 2 </b>
            (Prix Miyake de géochimie, Prix Tanaka)
          </li>
          <li>
            <b>A découvert: </b>
            une méthode de mesure du dioxyde de carbone dans l’eau de mer
          </li>
        </ul>
      </section>
    </div>
  );
}