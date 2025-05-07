import { getImageUrl } from './utils.js';

function test_size () {
    if (size < 90) {
        return 's'
    }
    else {
        return 'b'
    }
}

function Avatar({ person, size }) {
    return (
      <img
        className="avatar"
        src={getImageUrl(person, test_size(size))}
        alt={person.name}
        width={size}
        height={size}
      />
    );
  }
    

export default function Profile() {
  return (
    <Avatar
      size={40}
      person={{
        name: 'Gregorio Y. Zara',
        imageId: '7vQD0fP'
      }}
    />
  );
}
