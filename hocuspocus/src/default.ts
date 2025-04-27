import { Logger } from "@hocuspocus/extension-logger"
import { SQLite } from "@hocuspocus/extension-sqlite"
import { TiptapTransformer } from '@hocuspocus/transformer'
import { generateHTML } from '@tiptap/html'
import { Server } from "@hocuspocus/server"
import axios from 'axios'

// All the extensions we want to be a part of the schema
import { StarterKit } from '@tiptap/starter-kit'
import CodeBlockLowlight from '@tiptap/extension-code-block-lowlight'
import { Link } from '@tiptap/extension-link'

const server = new Server({
	port: 1234,
	address: "127.0.0.1",
	name: "hocuspocus-fra1-01",
	extensions: [
		new Logger(),
		new SQLite({
			database: "../storage/development_hocuspocus.sqlite3",
		}),
	],

	async onStoreDocument(data) {
		await new Promise((resolve, reject) => {
			// Transform the Yjs document to HTML
			const ydoc = TiptapTransformer.fromYdoc(data.document)
			let html = generateHTML(
				{
					type: 'doc',
					content: ydoc.default.content
				},
				[
					StarterKit.configure({ codeBlock: false }),
					Link,
					CodeBlockLowlight
				]
			)

			const railsAutosaveURL = `http://localhost:3000/docs/${data.document.name}/autosave`
			// Send the HTML to the Rails DB
			const payload = {
				document: {
					body: html
				}
			}
			axios.post(railsAutosaveURL, payload)
				.then(response => { })
				.catch(error => {
					console.error(`Error: ${error}`)
				})
		})
	}
});

// server.enableMessageLogging()

server.listen();
