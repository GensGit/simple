// For Ethereum, use the Infura endpoints
export default function rpcConfig(infuraKey?: string) {
  return process.env.NODE_ENV === 'production'
    ? 'https://mainnet.infura.io/v3/ed990be76f474f82997580db00405d43' // `https://mainnet.infura.io/v3/${infuraKey}`
    : 'https://rinkeby.infura.io/v3/ed990be76f474f82997580db00405d43'; // `https://rinkeby.infura.io/v3/${infuraKey}`
}
