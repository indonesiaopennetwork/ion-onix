## Introduction
- This folder contains the Dockerized version of Catalog Publisher installation for ION networks. 

## Steps

1. Using the Setup tab in ION Central devlabs, generate and register keys required for Beckn (Seller App). Once registered, click on the newly registered key. You will see the required information for the steps below. 
2. **Git clone** this repository. 
```
$ git clone https://github.com/indonesiaopennetwork/ion-onix.git`
```
3. Within the catalogPublisher folder, run the `configure-catalog-publisher.sh` script(**Catalog Publisher configuration script**). It asks for the data from step 1 above as well as the private key that was downloaded as part of step 1 above. It also asks for a web accessible address where the catalogs will be published. (e.g `https://criteria-overheat-modular.ngrok-free.dev/beckn`)
4. Run docker compose to bring up the adpater and support services. 
```
$ docker compose -f docker-compose-BPPAdapter.yml up --build
```
5. Ensure that the web accessible catalog path you provided in step 3 above is mapped to the data/beckn folder in the current folder. 
6. Publish your catalogs by sending message similar to the one listed after step 7. 
7. Within devlabs, update the path of the index file of the catalogs in the keys section (e.g. `https://criteria-overheat-modular.ngrok-free.dev/beckn/index/becknCatalogs.index.json`)

```
curl --location 'https://criteria-overheat-modular.ngrok-free.dev/catalog/publish' \
--header 'Content-Type: application/json' \
--data '{
  "context": {
    "action": "catalog/publish"
  },
  "message": {
    "catalogs": [
      {
        "id": "bpp-warung-vb.ion.id/CAT-GENERIC-001",
        "bppId": "bpp-warung-vb.ion.id",
        "bppUri": "https://criteria-overheat-modular.ngrok-free.dev/bpp/receiver",
        "isActive": true,
        "descriptor": {
          "name": "Generic Catalog",
          "shortDesc": "Daily essentials  generic items"
        },
        "provider": {
          "id": "PROV-EXAMPLE-01",
          "descriptor": {
            "name": "BP Pvt Ltd"
          },
          "availableAt": [
            {
              "geo": {
                "type": "Point",
                "coordinates": [
                  77.6401,
                  12.9116
                ]
              },
              "address": {
                "streetAddress": "27th Main Rd, Sector 2, HSR Layout",
                "addressLocality": "Bengaluru",
                "addressRegion": "Karnataka",
                "postalCode": "560102",
                "addressCountry": "IN"
              }
            }
          ]
        },
        "resources": [
          {
            "id": "ITEM-GENERIC-001",
            "descriptor": {
              "name": "Bru Gold Instant Coffee Powder",
              "shortDesc": "Rich and aromatic instant coffee powder, 200g",
              "longDesc": "Bru Gold is a premium blend of coffee and chicory, crafted for those who love a rich, flavourful cup. Made from handpicked coffee beans roasted to perfection, this instant coffee powder dissolves quickly to give you a smooth, aromatic brew every time. Whether you prefer your coffee black or with milk, Bru Gold delivers a satisfying coffee experience. Perfect for filter coffee, cappuccino, or a classic South Indian style coffee.",
              "mediaFile": [
                {
                  "uri": "https://www.jiomart.com/images/product/original/599173064/599173064.jpg",
                  "mimeType": "image/jpeg",
                  "label": "Product image"
                }
              ]
            },
            "provider": {
              "id": "PROV-EXAMPLE-01",
              "descriptor": {
                "name": "BP Pvt Ltd"
              }
            },
            "rating": {
              "ratingValue": 4.1,
              "ratingCount": 18200,
              "bestRating": 5,
              "worstRating": 1
            },
            "availableAt": [
              {
                "geo": {
                  "type": "Point",
                  "coordinates": [
                    77.6401,
                    12.9116
                  ]
                },
                "address": {
                  "streetAddress": "27th Main Rd, Sector 2, HSR Layout",
                  "addressLocality": "Bengaluru",
                  "addressRegion": "Karnataka",
                  "postalCode": "560102",
                  "addressCountry": "IN"
                }
              }
            ]
          },
          {
            "id": "ITEM-GENERIC-002",
            "descriptor": {
              "name": "Generic Classic Item",
              "shortDesc": "Pure soluble coffee, bold and rich, 100g",
              "longDesc": "Nescafe Classic is made from 100% pure coffee beans, carefully selected and roasted to deliver a bold, rich flavour in every cup. This instant coffee dissolves instantly in hot or cold water, making it ideal for a quick coffee fix anytime. The deep roast brings out natural coffee aromas that energise your mornings. Loved by coffee enthusiasts across India, Nescafe Classic is the trusted choice for a consistently great cup of coffee.",
              "mediaFile": [
                {
                  "uri": "https://m.media-amazon.com/images/S/aplus-media/vc/bb6a0196-cad0-4395-b85e-134ef725c0f7._CR0,0,1251,1251_PT0_SX300__.png",
                  "mimeType": "image/png",
                  "label": "Product image"
                }
              ]
            },
            "provider": {
              "id": "PROV-EXAMPLE-02",
              "descriptor": {
                "name": "Mart Pvt Ltd"
              }
            },
            "rating": {
              "ratingValue": 4.1,
              "ratingCount": 32500,
              "bestRating": 5,
              "worstRating": 1
            },
            "availableAt": [
              {
                "geo": {
                  "type": "Point",
                  "coordinates": [
                    76.6394,
                    12.2958
                  ]
                },
                "address": {
                  "streetAddress": "12 Sayyaji Rao Road, Devaraja Market",
                  "addressLocality": "Mysore",
                  "addressRegion": "Karnataka",
                  "postalCode": "570001",
                  "addressCountry": "IN"
                }
              }
            ]
          }
        ],
        "offers": [
          {
            "id": "OFFER-GENERIC-002",
            "descriptor": {
              "name": "Generic Bundle",
              "shortDesc": "Bru Gold + Nescafe Classic at 15% off - your morning coffee essentials"
            },
            "resourceIds": [
              "ITEM-GENERIC-001"
            ],
            "provider": {
              "id": "PROV-EXAMPLE-01",
              "descriptor": {
                "name": "Mart Pvt Ltd"
              }
            },
            "validity": {
              "startDate": "2026-03-04T00:00:00Z",
              "endDate": "2026-03-31T23:59:59Z"
            }
          },
          {
            "id": "OFFER-GROCERY-STAPLES-SAVER-002",
            "descriptor": {
              "name": "Hot Beverages Pack",
              "shortDesc": "Nescafe Classic + Tata Tea Premium combo - 10% off on your daily beverages"
            },
            "resourceIds": [
              "ITEM-GENERIC-002"
            ],
            "provider": {
              "id": "PROV-EXAMPLE-01",
              "descriptor": {
                "name": "Mart Pvt Ltd"
              }
            },
            "validity": {
              "startDate": "2026-03-04T00:00:00Z",
              "endDate": "2026-03-31T23:59:59Z"
            }
          }
        ]
      }
    ],
    "publishDirectives": [
      {
        "catalogId": "bpp-warung-vb.ion.id/CAT-GENERIC-001",
        "visibleTo": [
          "ion.id/staging"
        ],
        "catalogType": "REGULAR"
      }
    ]
  }
}'
```
