import {
    Lucid,
    Blockfrost,
    Address,
    MintingPolicy,
    PolicyId,
    Unit,
    fromText,
    Data,
    getAddressDetails,
    applyParamsToScript,
    AddressDetails,
} from "https://deno.land/x/lucid@0.9.1/mod.ts"

const lucid = await Lucid.new(
    new Blockfrost(
        "https://cardano-mainnet.blockfrost.io/api/v0",
        "mainnetu6R8AeevLAkkHw8UNdtKjZvmyjpW9DyW"
    ),
    "Mainnet"
);

lucid.selectWalletFromSeed("walk dove anchor away giant tilt subway finger donkey party reflect fresh improve say cruel corn dynamic ring barely wink require grab truly rule");
const addr: Address = await lucid.wallet.address();
//console.log("mon addresse nami : " + addr);

const addressDetails : AddressDetails = getAddressDetails (addr);
const someHash: string = addressDetails.paymentCredential?.hash || "";

console.log (addressDetails);
console.log (someHash);












// import { 
//     Lucid, 
//     Blockfrost, 
//     fromText, 
//     Data, 
//     getAddressDetails,
//     applyParamsToScript
//     } from "https://unpkg.com/lucid-cardano/web/mod.js";

//     const lucid = await Lucid.new(new Blockfrost("https://cardano-mainnet.blockfrost.io/api/v0", "mainnetu6R8AeevLAkkHw8UNdtKjZvmyjpW9DyW"), "Mainnet");
//     // load local stored seed as a wallet into lucid
//     const api = await window.cardano.yoroi.enable();
//     lucid.selectWallet(api);
//     const addr = await lucid.wallet.address();
//     console.log("own address: " + addr);

//     function getAdress() {
//         return addr;
//     }
//     addresseAffichage.textContent = getAdress();

//     const walletKeyHash = ((_a = getAddressDetails(addr).paymentCredential) === null || _a === void 0 ? void 0 : _a.hash) || "";
//     console.log("own pubkey hash: " + walletKeyHash);

//     function getPkh() {
//         return walletKeyHash;
//     }
//     cleAffichage.textContent = getPkh();
   