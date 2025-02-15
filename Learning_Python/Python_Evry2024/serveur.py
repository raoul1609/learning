import socket
import threading

def handle_client(client_socket):
    while True:
        try:
            # Recevoir le message du client
            message = client_socket.recv(1024).decode('utf-8')
            if not message:
                break
            print(f"Message reçu du client : {message}")

            # Envoyer une réponse au client
            #response = f"Le serveur a reçu votre message : {message}"
            #
            reponseDuServeur = input("Repondre au client: ")
            client_socket.send(reponseDuServeur.encode('utf-8'))
        except Exception as e:
            print(f"Erreur : {e}")
            break

    # Fermer la connexion avec le client
    client_socket.close()
    print("Connexion avec le client fermée.")

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(('0.0.0.0', 5555))  # Écoute sur toutes les interfaces, port 5555
    server.listen(5)
    print("Serveur démarré sur le port 5555. En attente de connexions...")

    while True:
        client_socket, addr = server.accept()
        print(f"Connexion établie avec {addr}")
        thread = threading.Thread(target=handle_client, args=(client_socket,))
        thread.start()

if __name__ == "__main__":
    start_server()