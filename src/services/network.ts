import { API_URL } from "~constants"
import { ApolloClient, InMemoryCache } from "@apollo/client"

export const client = new ApolloClient({
  uri: API_URL,
  cache: new InMemoryCache(),
})
