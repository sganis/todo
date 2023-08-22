import { fail, redirect } from '@sveltejs/kit';
import prisma from '$lib/prisma';

export const load = async () => {
	const response = await prisma.todo.findMany();
	return { todos: response };
};

export const actions = {
	create: async ({ request }) => {
		const data = await request.formData();
		const todo = await prisma.todo.create({
			data: {
				text: data.get('text'),
				done: false,
				created_at: new Date()
			}
		});
		return { message: 'todo created' };
	},

	save: async ({ request }) => {
		const data = await request.formData();
		const todo = await prisma.todo.update({
			where: {
				uid: data.get('uid')
			},
			data: {
				text: data.get('text')
			}
		});
		return { message: 'todo saved' };
	},

	delete: async ({ request }) => {
		const data = await request.formData();
		const todo = await prisma.todo.delete({
			where: {
				uid: data.get('uid')
			}
		});
		return { message: 'todo deleted' };
	},
	toggle: async ({ request }) => {
		const data = await request.formData();
		const todo_db = await prisma.todo.findUnique({
			where: {
				uid: data.get('uid')
			}
		});
		const todo = await prisma.todo.update({
			where: {
				uid: data.get('uid')
			},
			data: {
				done: !todo_db?.done
			}
		});
		return { message: 'todo saved' };
	}
};
