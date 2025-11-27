-- Customer Database Initialization Script
-- Creates tables and populates with Portuguese PII data for anonymization testing

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    address TEXT,
    company VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create interactions table
CREATE TABLE IF NOT EXISTS interactions (
    id SERIAL PRIMARY KEY,
    custom_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    interaction_type VARCHAR(50) NOT NULL,
    subject VARCHAR(255),
    description TEXT NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Portuguese customers with PII data
INSERT INTO customers (name, email, phone, address, company, notes) VALUES
('João Silva Santos', 'joao.silva@techcorp.pt', '+351 912 345 678', 
 'Rua das Flores, 123, 4º Andar
4000-230 Porto', 
 'TechCorp Solutions', 
 'Cliente VIP desde 2020. Contactar sempre por email. Reunião agendada com Maria Costa para próxima semana.'),

('Maria Costa Ferreira', 'maria.ferreira@innovate.pt', '+351 933 456 789', 
 'Avenida da Liberdade, 456
1250-096 Lisboa', 
 'Innovate Digital', 
 'Interessada em soluções cloud. Pediu orçamento ao Pedro Oliveira. Email de follow-up: pedro@ltplabs.pt'),

('Carlos Rodrigues Almeida', 'carlos.almeida@webstart.pt', '+351 966 123 456', 
 'Praça do Comércio, 78, Loja 5
3000-148 Coimbra', 
 'WebStart Agency', 
 'Lead gerado em conferência. Conversar com Ana Silva (ana.silva@ltplabs.pt) sobre pricing.'),

('Ana Paula Martins', 'ana.martins@digitalflow.pt', '+351 915 678 901', 
 'Rua de Santa Catarina, 234, Sala 12
4000-442 Porto', 
 'DigitalFlow Studios', 
 'Projeto em curso. Contactos: João Santos (dev lead) - joao@digitalflow.pt, Luis Pereira (PM)'),

('Pedro Miguel Sousa', 'pedro.sousa@cloudtech.pt', '+351 928 345 012', 
 'Rua Garrett, 89, 2º Esq
1200-203 Lisboa', 
 'CloudTech Innovations', 
 'Contrato terminado em 2023. Último contacto: Rita Santos (rita.santos@ltplabs.pt)'),

('Rita Isabel Fernandes', 'rita.fernandes@smartsys.pt', '+351 934 567 123', 
 'Avenida dos Aliados, 567
4000-065 Porto', 
 'SmartSys Solutions', 
 'Cliente premium. Renovação automática. Contacto técnico: miguel.costa@smartsys.pt'),

('Miguel Ângelo Costa', 'miguel.costa@innovatech.pt', '+351 967 890 234', 
 'Rua do Ouro, 145, 3º Dto
1100-061 Lisboa', 
 'InnovaTech Group', 
 'Interessado em migração. Referenciado por João Silva. Email para orçamento: vendas@ltplabs.pt'),

('Sofia Alexandra Pereira', 'sofia.pereira@webnext.pt', '+351 919 012 345', 
 'Praça da República, 23, Loja A
3000-343 Coimbra', 
 'WebNext Agency', 
 'Reunião mensal com Carlos Rodrigues (account manager). Próximo check-in: 15/12/2024'),

('Luís Fernando Oliveira', 'luis.oliveira@datawise.pt', '+351 932 123 567', 
 'Rua de Cedofeita, 678, 1º Andar
4050-180 Porto', 
 'DataWise Analytics', 
 'Cliente desde 2019. Contacto preferencial: email. Supervisor: ana.martins@ltplabs.pt'),

('Beatriz Gonçalves Silva', 'beatriz.silva@nextstep.pt', '+351 945 678 901', 
 'Avenida Fontes Pereira de Melo, 890
1050-121 Lisboa', 
 'NextStep Consulting', 
 'Lead qualificado. Reunião agendada com Pedro Sousa (pedro@ltplabs.pt) para demo.');

-- Insert interactions with PII in descriptions
INSERT INTO interactions (custom_id, interaction_type, subject, description, created_by) VALUES
(1, 'email', 'Proposta Comercial', 
 'Enviado email com proposta para joao.silva@techcorp.pt. Aguardando resposta. Cópia para Maria Costa (maria.costa@ltplabs.pt).', 
 'João Silva (Account Manager)'),

(1, 'call', 'Follow-up Comercial', 
 'Ligação telefónica com João Santos. Discutidos requisitos técnicos. Próxima reunião com Ana Silva marcada para 20/11.', 
 'Maria Costa (Sales)'),

(2, 'meeting', 'Reunião de Kick-off', 
 'Reunião realizada no escritório do cliente. Presentes: Maria Ferreira, Pedro Oliveira (pedro.oliveira@ltplabs.pt) e Rita Santos.', 
 'Carlos Rodrigues (Support)'),

(2, 'support', 'Incidente - Sistema Offline', 
 'Reportado por maria.ferreira@innovate.pt. Incidente resolvido pela equipa técnica. Contacto: Luis Pereira (suporte@ltplabs.pt).', 
 'Ana Paula Martins (Account Manager)'),

(3, 'email', 'Orçamento - Migração', 
 'Solicitação de orçamento recebida de carlos.almeida@webstart.pt. Encaminhado para vendas@ltplabs.pt para análise.', 
 'Pedro Miguel Sousa (Technical Lead)'),

(3, 'call', 'Consulta Técnica', 
 'Cliente ligou com dúvidas sobre integração. Atendido por Ana Silva. Escalado para pedro.sousa@ltplabs.pt.', 
 'Rita Isabel Fernandes (Sales Manager)'),

(4, 'meeting', 'Apresentação de Roadmap', 
 'Apresentação de novas features. Presentes: Ana Martins, João Santos (joao@digitalflow.pt) e Luis Pereira. Feedback positivo.', 
 'Miguel Ângelo Costa (Support Engineer)'),

(4, 'email', 'Renovação de Contrato', 
 'Email enviado para ana.martins@digitalflow.pt sobre renovação. CC: miguel.costa@ltplabs.pt. Aguardando aprovação.', 
 'Sofia Alexandra Pereira (Customer Success)'),

(5, 'call', 'Cancelamento de Serviço', 
 'Pedro Sousa informou cancelamento. Contacto de despedida enviado por rita.santos@ltplabs.pt. Cliente satisfeito com serviço prestado.', 
 'João Silva (Account Manager)'),

(6, 'support', 'Pedido de Funcionalidade', 
 'Cliente pediu nova funcionalidade. Email de rita.fernandes@smartsys.pt. Ticket criado e atribuído a Miguel Costa (dev team).', 
 'Maria Costa (Sales)'),

(6, 'email', 'Check-in Mensal', 
 'Email de follow-up enviado para miguel.costa@smartsys.pt. Próxima reunião agendada para 30/11.', 
 'Carlos Rodrigues (Support)'),

(7, 'meeting', 'Demo Comercial', 
 'Demonstração de produto para Miguel Costa. Presentes: vendas@ltplabs.pt e João Silva. Cliente interessado.', 
 'Ana Paula Martins (Account Manager)'),

(8, 'call', 'Check-in de Rotina', 
 'Ligação mensal com Sofia Pereira. Tudo a correr bem. Próximo contacto: carlos.rodrigues@ltplabs.pt.', 
 'Pedro Miguel Sousa (Technical Lead)'),

(8, 'email', 'Relatório de Progresso', 
 'Enviado relatório para sofia.pereira@webnext.pt. Métricas anexadas. CC: ana.silva@ltplabs.pt.', 
 'Rita Isabel Fernandes (Sales Manager)'),

(9, 'support', 'Atualização de Sistema', 
 'Sistema atualizado conforme solicitado por luis.oliveira@datawise.pt. Contacto técnico: suporte@ltplabs.pt.', 
 'Miguel Ângelo Costa (Support Engineer)'),

(9, 'meeting', 'Reunião Trimestral', 
 'Reunião de review. Presentes: Luís Oliveira, Ana Martins (ana.martins@ltplabs.pt) e equipa técnica.', 
 'Sofia Alexandra Pereira (Customer Success)'),

(10, 'email', 'Agendamento de Demo', 
 'Email para beatriz.silva@nextstep.pt confirmando demo. Será realizada por Pedro Sousa (pedro@ltplabs.pt).', 
 'João Silva (Account Manager)'),

(10, 'call', 'Qualificação de Lead', 
 'Ligação de qualificação com Beatriz Silva. Lead válido. Próximos passos: enviar proposta para vendas@ltplabs.pt.', 
 'Maria Costa (Sales)');

-- Create indexes for performance
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_interactions_customer ON interactions(custom_id);
CREATE INDEX idx_interactions_type ON interactions(interaction_type);

-- Verify data
SELECT 'Database initialized successfully!' as status;
SELECT COUNT(*) as total_customers FROM customers;
SELECT COUNT(*) as total_interactions FROM interactions;