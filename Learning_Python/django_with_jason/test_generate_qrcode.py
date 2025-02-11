import qrcode

# Les données que vous voulez encoder dans le QR Code
#data = "https://www.example.com"
data = "hello world: premier test de generation de qrcode"

# Créer une instance de QRCode
qr = qrcode.QRCode(
    version=1,  # La taille du QR Code (1-40, None pour auto)
    error_correction=qrcode.constants.ERROR_CORRECT_L, # Niveau de correction d'erreur (L, M, Q, H)
    box_size=10, # La taille de chaque "boîte" du QR Code
    border=4, # La largeur de la bordure blanche autour du QR Code
)

# Ajouter les données au QR Code
qr.add_data(data)
qr.make(fit=True) # Ajuste la taille du QR Code aux données

# Créer une image du QR Code
img = qr.make_image(fill_color="black", back_color="white")

# Sauvegarder l'image
img.save("qrcode_simple.png")
print("QR code généré")